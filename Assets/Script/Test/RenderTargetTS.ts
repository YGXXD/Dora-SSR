/*
local root = Node()

local node = Node()
node:addTo(root, 1)

local spine = Spine("Spine/moling")
spine.y = -200
spine.scaleX = 1.2
spine.scaleY = 1.2
spine.fliped = false
spine:play("fmove", true)
spine:runAction(
	Sequence(
		X(2, -150, 250),
		Event("Turn"),
		X(2, 250, -150),
		Event("Turn")
	)
)
spine:slot("ActionEnd", function(action: Action.Type)
	spine:runAction(action)
end)
spine:slot("Turn", function()
	spine.fliped = not spine.fliped
end)
spine:addTo(node)

local renderTarget = RenderTarget(300, 400)
renderTarget:renderWithClear(Color(0xff8a8a8a))

local surface = Sprite(renderTarget.texture)
surface.z = 300
surface.angleY = 25
surface:addChild(Line({
	Vec2.zero,
	Vec2(300, 0),
	Vec2(300, 400),
	Vec2(0, 400),
	Vec2.zero
}, App.themeColor))
surface:schedule(function(): boolean
	node.y = 200
	renderTarget:renderWithClear(node, Color(0xff8a8a8a))
	node.y = 0
	return false
end)
surface:addTo(root)

-- example codes ends here, some test ui below --

local ImGui <const> = require("ImGui")

local windowFlags = {
	"NoDecoration",
	"AlwaysAutoResize",
	"NoSavedSettings",
	"NoFocusOnAppearing",
	"NoNav",
	"NoMove"
}
threadLoop(function(): boolean
	local width = App.visualSize.width
	ImGui.SetNextWindowBgAlpha(0.35)
	ImGui.SetNextWindowPos(Vec2(width - 10, 10), "Always", Vec2(1, 0))
	ImGui.SetNextWindowSize(Vec2(240, 0), "FirstUseEver")
	ImGui.Begin("Render Target", windowFlags, function()
		ImGui.Text("Render Target")
		ImGui.Separator()
		ImGui.TextWrapped("Use render target node as a mirror!")
	end)
end)
*/

import { WindowFlag, SetCond } from "ImGui";
import * as ImGui from "ImGui";
import { App, Color, Event, Line, Node, RenderTarget, Sequence, Slot, Spine, Sprite, Vec2, X, threadLoop } from "dora";

const root = Node();

const node = Node().addTo(root, 1);

const spine = Spine("Spine/moling").addTo(node);
spine.y = -200;
spine.scaleX = 1.2;
spine.scaleY = 1.2;
spine.fliped = false;
spine.play("fmove", true);
spine.runAction(
	Sequence(
		X(2, -150, 250),
		Event("Turn"),
		X(2, 250, -150),
		Event("Turn")
	)
);
spine.slot(Slot.ActionEnd, action => {
	spine.runAction(action);
});
spine.slot("Turn", () => {
	spine.fliped = !spine.fliped;
});

const renderTarget = RenderTarget(300, 400);
renderTarget.renderWithClear(Color(0xff8a8a8a));

const surface = Sprite(renderTarget.texture).addTo(root);
surface.z = 300;
surface.angleY = 25;
surface.addChild(Line([
	Vec2.zero,
	Vec2(300, 0),
	Vec2(300, 400),
	Vec2(0, 400),
	Vec2.zero
], App.themeColor));
surface.schedule(() => {
	node.y = 200;
	renderTarget.renderWithClear(node, Color(0xff8a8a8a));
	node.y = 0;
	return false;
});


const windowFlags = [
	WindowFlag.NoDecoration,
	WindowFlag.AlwaysAutoResize,
	WindowFlag.NoSavedSettings,
	WindowFlag.NoFocusOnAppearing,
	WindowFlag.NoNav,
	WindowFlag.NoMove
];
threadLoop(() => {
	const size = App.visualSize;
	ImGui.SetNextWindowBgAlpha(0.35);
	ImGui.SetNextWindowPos(Vec2(size.width - 10, 10), SetCond.Always, Vec2(1, 0));
	ImGui.SetNextWindowSize(Vec2(240, 0), SetCond.FirstUseEver);
	ImGui.Begin("Render Target", windowFlags, () => {
		ImGui.Text("Render Target");
		ImGui.Separator();
		ImGui.TextWrapped("Use render target node as a mirror!");
	});
	return false;
});