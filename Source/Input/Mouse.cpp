/* Copyright (c) 2024 Li Jin, dragon-fly@qq.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. */

#include "Const/Header.h"

#include "Input/Mouse.h"

#include "Basic/Director.h"
#include "Input/TouchDispather.h"

NS_DORA_BEGIN

Vec2 Mouse::getPosition() {
	return SharedDirector.getUITouchHandler()->getMousePos();
}

bool Mouse::isLeftButtonPressed() {
	return SharedDirector.getUITouchHandler()->isLeftButtonPressed();
}

bool Mouse::isRightButtonPressed() {
	return SharedDirector.getUITouchHandler()->isRightButtonPressed();
}

bool Mouse::isMiddleButtonPressed() {
	return SharedDirector.getUITouchHandler()->isMiddleButtonPressed();
}

float Mouse::getWheel() {
	return SharedDirector.getUITouchHandler()->getMouseWheel();
}

NS_DORA_END