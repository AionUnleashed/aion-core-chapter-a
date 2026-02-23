Purpose
-------
This file gives concise, actionable guidance for AI coding agents to be immediately productive in this repository.

Quick summary
-------------
- Monorepo with four primary runtime components: Login, Game, Chat, and Commons.
- Login/Game/Chat are built with Ant; Commons uses Maven.
- Build orchestrator: [Builder.bat](Builder.bat) (menu-driven). Commons helper: [build_maven_commons.bat](build_maven_commons.bat).

Big-picture architecture
------------------------
- Modules at repository root: [AC-Login](AC-Login), [AC-Game](AC-Game), [AC-Chat](AC-Chat), [AC-Commons](AC-Commons).
- Java sources follow package root `com.aionemu.*` under each module's `src/` folder (e.g., [AC-Game/src](AC-Game/src)).
- Runtime separation: each server (Login/Game/Chat) is its own JVM process configured via per-module `config/` directories and XML properties under `config/` and `data/`.
- Shared code and libraries live in `AC-Commons` and local `libs/` folders under each module.

Build / run / debug workflows
-----------------------------
- Typical local build: run [Builder.bat](Builder.bat) and choose the server to build; it calls Ant in `AC-Tools/Ant` for Login/Game/Chat and Maven for Commons via [build_maven_commons.bat](build_maven_commons.bat).
- To build a specific module manually:
  - Commons: run `mvn clean package` from `AC-Commons` (see [build_maven_commons.bat](build_maven_commons.bat)).
  - Game/Login/Chat: run the Ant wrapper in the module directory, e.g. start `AC-Tools/Ant/bin/ant` from `AC-Game` (see [AC-Game/build_gameserver.bat](AC-Game/build_gameserver.bat)).
- Debug: use Builder menu option 8 which sets `MODE=clean package -e -X` to enable verbose/debug builds.

Key configuration and integration points
---------------------------------------
- Database: find DB properties in [AC-Commons/config/network/database.properties](AC-Commons/config/network/database.properties) and SQL schema under [AC-Game/sql/ac47_server_gs.sql](AC-Game/sql/ac47_server_gs.sql).
- Server properties: main runtime options are under module `config/` directories (e.g., [AC-Game/config/main](AC-Game/config/main)).
- Packets & protocol: packet definitions and updates live under `AC-Game/data/packets` and `AC-Game/data/` XML templates — changes here are protocol-sensitive.
- Scripts & assets: content and game data are under `AC-Game/data/`, `scripts/`, and `static_data/` (edit carefully; many game behaviors rely on these XML templates).

Project-specific conventions
----------------------------
- Package root: `com.aionemu.*`. Preserve package structure when moving classes between modules.
- Two build systems: Ant for runtime servers and Maven for shared commons. Do not try to convert Commons to Ant without verifying dependency handling.
- Many game behaviors are data-driven (XML under `data/`, `scripts/`, `config/`). Prefer updating templates over hard-coding gameplay logic where possible.
- Opcode/protocol changes are pervasive: changing packet names/opcodes requires synchronized edits in `data/packets`, server code, and sometimes client-side expectations.

What an AI agent should look for first
------------------------------------
1. `Builder.bat` and module `build_*.bat` files to understand how builds are launched (links: [Builder.bat](Builder.bat), [AC-Game/build_gameserver.bat](AC-Game/build_gameserver.bat)).
2. `AC-Commons/pom.xml` to see shared dependencies and artifact names.
3. `AC-Game/config/` and `AC-Login/config/` to identify runtime properties that must be updated when changing behavior.
4. Packet definitions under `AC-Game/data/packets` before editing networking code.

Do NOT assume
-------------
- There is no `.github` automation or CI configured in this repo — make no changes that assume CI hooks exist.
- The project expects Windows-style helper scripts (`.bat`) and an Ant binary included at `AC-Tools/Ant` — builds may be platform-sensitive.

Examples (concrete pointers)
----------------------------
- Build Commons: [build_maven_commons.bat](build_maven_commons.bat) → `AC-Commons` → `mvn clean package`.
- Build Game: [AC-Game/build_gameserver.bat](AC-Game/build_gameserver.bat) → starts `AC-Tools/Ant/bin/ant` in `AC-Game`.
- DB schema: [AC-Game/sql/ac47_server_gs.sql](AC-Game/sql/ac47_server_gs.sql).
- Shared config: [AC-Commons/config/network/database.properties](AC-Commons/config/network/database.properties).

If anything is unclear or you want more detail about a particular module (packets, DB, build flags), say which area and I'll iterate. 
