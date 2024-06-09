# FirstGodotGame
Followed [Brackeys' Godot Beginner Tutorial](https://www.youtube.com/watch?v=LOhfqjmasi0) and [Battery Acid Dev's Add Multiplayer to your Godot Game!](https://www.youtube.com/watch?v=V4a_J38XdHk)

## WebGL build
<a href="https://runninglvlan.github.io/FirstGodotGame/"><img src="/docs/thumbnail.png" /></a>

## Important

File encoding is important: scenes need to use **UTF-8** without BOM, otherwise the engine might have trouble parsing them

Godot signals are similar to C# events, use `connect`/`disconnect` to subscribe/unsubscribe from them

It's possible to run multiple instances right away in _Debug > Run Multiple Instances_

After running the game, _Remote_ button appears so that live game scene could be observed
- If multiple instances are run, in the _Debugger_ panel there are _Sessions_ tabs to switch between Remote scenes

## Multiplayer

There's no client side prediction and transform updates are server-side so client movement is jittery.

## Useful resources
- [Godot Docs](https://docs.godotengine.org/en/stable/index.html)
- [Godot Repo](https://github.com/godotengine/godot)
- [Guide to deploy to GitHub Pages](http://angelicgarbage.com/posts/how-to-deploy-a-godot-4-game-to-github-pages/)
