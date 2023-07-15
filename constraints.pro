% Yarn Constraints https://yarnpkg.com/features/constraints
% check with "yarn constraints" (fix w/ "yarn constraints --fix")

% Enforces that a dependency doesn't appear in both `dependencies` and `devDependencies`
gen_enforced_dependency(WorkspaceCwd, DependencyIdent, null, 'devDependencies') :-
  workspace_has_dependency(WorkspaceCwd, DependencyIdent, _, 'devDependencies'),
  workspace_has_dependency(WorkspaceCwd, DependencyIdent, _, 'dependencies').

% Prevent two workspaces from depending on conflicting versions of a same dependency
gen_enforced_dependency(WorkspaceCwd, DependencyIdent, DependencyRange2, DependencyType) :-
  workspace_has_dependency(WorkspaceCwd, DependencyIdent, DependencyRange, DependencyType),
  workspace_has_dependency(OtherWorkspaceCwd, DependencyIdent, DependencyRange2, DependencyType2),
  % Exclude peer dependencies
  (DependencyType \= 'peerDependencies', DependencyType2 \= 'peerDependencies'),
  DependencyRange \= DependencyRange2.

% Ensure '>=' peerDependencies use appropriate version
gen_enforced_dependency(WorkspaceCwd, DependencyIdent, DependencyRange2, DependencyType) :-
  workspace_has_dependency(WorkspaceCwd, DependencyIdent, DependencyRange, DependencyType),
  workspace_has_dependency(OtherWorkspaceCwd, DependencyIdent, DependencyRange2, DependencyType2),
  % Include peer dependencies
  DependencyType2 = 'peerDependencies',
  % Include dependency ranges that start with '>= '
  atom_concat('>= ', _, DependencyRange2),
  % Get desired version
  atom_concat('>= ', DesiredVersion, DependencyRange2),
  % Get length of desired version
  atom_length(DesiredVersion, VersionLength),
  % Get given version limited to desired length
  sub_atom(DependencyRange, 0, VersionLength, _, GivenVersion),
  DesiredVersion \= GivenVersion.

% Prevents a dependency from having a caret in its version
gen_enforced_dependency(WorkspaceCwd, DependencyIdent, TargetDependencyRange, DependencyType) :-
  % Exclude peer dependencies
  DependencyType \= 'peerDependencies',
  workspace_has_dependency(WorkspaceCwd, DependencyIdent, CurrentDependencyRange, DependencyType),
  atom_concat('^', TargetDependencyRange, CurrentDependencyRange).

% Enforces that all workspaces depend on other workspaces using `workspace:*`
gen_enforced_dependency(WorkspaceCwd, DependencyIdent, 'workspace:*', DependencyType) :-
  workspace_has_dependency(WorkspaceCwd, DependencyIdent, DependencyRange, DependencyType),
  % Only consider dependency ranges that start with 'workspace:'
  atom_concat('workspace:', _, DependencyRange),
  % Only consider 'dependencies' and 'devDependencies'
  (DependencyType = 'dependencies'; DependencyType = 'devDependencies').

% Prevents workspaces from depending on non-workspace versions of available workspaces
gen_enforced_dependency(WorkspaceCwd, DependencyIdent, 'workspace:*', DependencyType) :-
  % Iterates over all dependencies from all workspaces
  workspace_has_dependency(WorkspaceCwd, DependencyIdent, DependencyRange, DependencyType),
  % Only consider those that target something that could be a workspace
  workspace_ident(DependencyCwd, DependencyIdent).

% Enforces the license in all public workspaces while removing it from private workspaces
gen_enforced_field(WorkspaceCwd, 'license', 'MIT') :-
  \+ workspace_field(WorkspaceCwd, 'private', true),
  workspace_ident(WorkspaceCwd, WorkspaceIdent).
gen_enforced_field(WorkspaceCwd, 'license', null) :-
  workspace_field(WorkspaceCwd, 'private', true).

% Enforces the repository field for all public workspaces while removing it from private workspaces
gen_enforced_field(WorkspaceCwd, 'repository.type', 'git') :-
  \+ workspace_field(WorkspaceCwd, 'private', true).
gen_enforced_field(WorkspaceCwd, 'repository.url', 'https://github.com/lunchbreakdev/lunchbreak') :-
  \+ workspace_field(WorkspaceCwd, 'private', true).
gen_enforced_field(WorkspaceCwd, 'repository.directory', WorkspaceCwd) :-
  \+ workspace_field(WorkspaceCwd, 'private', true).
gen_enforced_field(WorkspaceCwd, 'funding', null) :-
  workspace_field(WorkspaceCwd, 'private', true).

% Enforces the bugs field for all public workspaces while removing it from private workspaces
gen_enforced_field(WorkspaceCwd, 'bugs.url', 'https://github.com/lunchbreakdev/lunchbreak/issues') :-
  \+ workspace_field(WorkspaceCwd, 'private', true).
gen_enforced_field(WorkspaceCwd, 'bugs', null) :-
  workspace_field(WorkspaceCwd, 'private', true).

% Enforces the funding field for all public workspaces while removing it from private workspaces
gen_enforced_field(WorkspaceCwd, 'funding.type', 'github') :-
  \+ workspace_field(WorkspaceCwd, 'private', true).
gen_enforced_field(WorkspaceCwd, 'funding.url', 'https://github.com/sponsors/spencerlabs') :-
  \+ workspace_field(WorkspaceCwd, 'private', true).
gen_enforced_field(WorkspaceCwd, 'repository', null) :-
  workspace_field(WorkspaceCwd, 'private', true).

% Enforces 'publishConfig.access' is set to public for public workspaces while removing it from private workspaces
gen_enforced_field(WorkspaceCwd, 'publishConfig.access', 'public') :-
  \+ workspace_field(WorkspaceCwd, 'private', true).
gen_enforced_field(WorkspaceCwd, 'publishConfig.access', null) :-
  workspace_field(WorkspaceCwd, 'private', true).

% Enforces the engines.node field for all workspaces while removing it from private workspaces
gen_enforced_field(WorkspaceCwd, 'engines.node', '^16.20.0 || ^18.16.0 || >=20.0.0') :-
  \+ workspace_field(WorkspaceCwd, 'private', true).
gen_enforced_field(WorkspaceCwd, 'engines.node', null) :-
  workspace_field(WorkspaceCwd, 'private', true).

% Enforces the author field to be consistent
gen_enforced_field(WorkspaceCwd, 'author', 'Lunch Break Dev (https://lunchbreak.dev)') :-
  \+ workspace_field(WorkspaceCwd, 'private', true).
gen_enforced_field(WorkspaceCwd, 'author', null) :-
  workspace_field(WorkspaceCwd, 'private', true).

% Enforces the main and types field to start with ./
gen_enforced_field(WorkspaceCwd, FieldName, ExpectedValue) :-
  % Fields the rule applies to
  member(FieldName, ['main', 'types', 'module', 'es2015', 'es2017', 'collection', 'collection:main', 'unpkg']),
  % Get current value
  workspace_field(WorkspaceCwd, FieldName, CurrentValue),
  % Must not start with ./ already
  \+ atom_concat('./', _, CurrentValue),
  % Store './' + CurrentValue in ExpectedValue
  atom_concat('./', CurrentValue, ExpectedValue).

% Enforces the type field to be set  for public workspaces while removing it from private workspaces
gen_enforced_field(WorkspaceCwd, 'type', 'commonjs') :-
  \+ workspace_field(WorkspaceCwd, 'private', true),
  \+ workspace_field(WorkspaceCwd, 'type', 'module').
gen_enforced_field(WorkspaceCwd, 'type', null) :-
  workspace_field(WorkspaceCwd, 'private', true).

% Ensure the homepage field points to the correct page for publishable packages
gen_enforced_field(WorkspaceCwd, 'homepage', Homepage) :-
  \+ workspace_field(WorkspaceCwd, 'private', true),
  workspace_ident(WorkspaceCwd, WorkspaceIdent),
  % Get package name by removing '@lunchbreak/' prefix
  atom_concat('@lunchbreak/', Name, WorkspaceIdent),
  atom_concat('https://lunchbreak.dev/packages/', Name, Homepage).
