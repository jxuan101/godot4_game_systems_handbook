#!/usr/bin/env python3
"""Static repository audit; does not replace Godot's own parser/runtime tests."""
from pathlib import Path
import re, sys, zipfile
ROOT = Path(__file__).resolve().parent
GUIDES = list((ROOT / 'handbook/systems').glob('*/**/README.md'))
EXAMPLES = list((ROOT / 'project/scripts/examples').glob('*/*.gd'))
errors=[]
if len(GUIDES) != 80: errors.append(f'expected 80 guides, found {len(GUIDES)}')
if len(EXAMPLES) != 80: errors.append(f'expected 80 examples, found {len(EXAMPLES)}')
classes={}
for guide in GUIDES:
    rel=guide.parent.relative_to(ROOT/'handbook/systems')
    script=ROOT/'project/scripts/examples'/rel.parent/(rel.name+'.gd')
    if not script.exists(): errors.append(f'missing example for {guide}')
    if not re.search(r'project/scripts/examples/.+\.gd', guide.read_text()): errors.append(f'guide has no code link: {guide}')
    # Resolve markdown relative path links and check local target exists.
    for target in re.findall(r'\]\(([^)]+)\)', guide.read_text()):
        if target.startswith(('http://','https://','#','mailto:')): continue
        path=(guide.parent/target.split('#')[0]).resolve()
        if not path.exists(): errors.append(f'broken guide link {guide}: {target}')
for script in EXAMPLES:
    text=script.read_text()
    m=re.search(r'^class_name\s+(\w+)', text, re.M)
    if not m: errors.append(f'missing class_name: {script}')
    elif m.group(1) in classes: errors.append(f'duplicate class_name {m.group(1)}: {script} and {classes[m.group(1)]}')
    else: classes[m.group(1)]=script
    if not re.search(r'^extends\s+\w+', text, re.M): errors.append(f'missing extends: {script}')
    if re.search(r'\b(pass|TODO|FIXME)\b', text): errors.append(f'placeholder marker in {script}')
    if not re.search(r'^func\s+\w+', text, re.M): errors.append(f'no functions in {script}')
# Every Input.* action referenced in examples must be defined in project.godot.
all_text='\n'.join(p.read_text() for p in EXAMPLES)
used=set()
for call in re.findall(r'Input\.(?:is_action_just_pressed|is_action_just_released|is_action_pressed|get_axis|get_vector)\(([^)]*)\)', all_text):
    used.update(re.findall(r'"([^"]+)"', call))
config=(ROOT/'project/project.godot').read_text()
defined=set(re.findall(r'^([a-zA-Z0-9_]+)=\{', config, re.M))
for action in sorted(used-defined): errors.append(f'input action not configured: {action}')
# Quick lexical balance check after stripping comments and quoted strings.
for script in EXAMPLES:
    text=script.read_text()
    text=re.sub(r'(?m)#.*$', '', text)
    text=re.sub(r'"(?:\\.|[^"\\])*"|\'(?:\\.|[^\'\\])*\'', 'STR', text)
    for left,right in [('(',')'),('[',']'),('{','}')]:
        if text.count(left) != text.count(right): errors.append(f'unbalanced {left}{right} in {script}')
if errors:
    print('\n'.join('FAIL: '+e for e in errors)); sys.exit(1)
print(f'PASS: {len(GUIDES)} guides, {len(EXAMPLES)} concrete scripts, {len(classes)} unique classes, {len(used)} configured input actions, all guide links resolve.')
print('LIMIT: static checks only; Godot parser/import/runtime was not available.')
