/* Copyright (c) 2024 Li Jin, dragon-fly@qq.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. */

extern "C" {
using namespace Dora;
void httpclient_post_async(int64_t url, int64_t json, float timeout, int32_t func, int64_t stack) {
	std::shared_ptr<void> deref(nullptr, [func](auto) {
		SharedWasmRuntime.deref(func);
	});
	auto args = r_cast<CallStack*>(stack);
	SharedHttpClient.postAsync(*Str_From(url), *Str_From(json), timeout, [func, args, deref](OptString body) {
		args->clear();
		args->push(body);
		SharedWasmRuntime.invoke(func);
	});
}
void httpclient_post_with_headers_async(int64_t url, int64_t headers, int64_t json, float timeout, int32_t func, int64_t stack) {
	std::shared_ptr<void> deref(nullptr, [func](auto) {
		SharedWasmRuntime.deref(func);
	});
	auto args = r_cast<CallStack*>(stack);
	SharedHttpClient.postAsync(*Str_From(url), Vec_FromStr(headers), *Str_From(json), timeout, [func, args, deref](OptString body) {
		args->clear();
		args->push(body);
		SharedWasmRuntime.invoke(func);
	});
}
void httpclient_get_async(int64_t url, float timeout, int32_t func, int64_t stack) {
	std::shared_ptr<void> deref(nullptr, [func](auto) {
		SharedWasmRuntime.deref(func);
	});
	auto args = r_cast<CallStack*>(stack);
	SharedHttpClient.getAsync(*Str_From(url), timeout, [func, args, deref](OptString body) {
		args->clear();
		args->push(body);
		SharedWasmRuntime.invoke(func);
	});
}
void httpclient_download_async(int64_t url, int64_t full_path, float timeout, int32_t func, int64_t stack) {
	std::shared_ptr<void> deref(nullptr, [func](auto) {
		SharedWasmRuntime.deref(func);
	});
	auto args = r_cast<CallStack*>(stack);
	SharedHttpClient.downloadAsync(*Str_From(url), *Str_From(full_path), timeout, [func, args, deref](bool interrupted, uint64_t current, uint64_t total) {
		args->clear();
		args->push(interrupted);
		args->push(current);
		args->push(total);
		SharedWasmRuntime.invoke(func);
		return std::get<bool>(args->pop());
	});
}
} // extern "C"

static void linkHttpClient(wasm3::module3& mod) {
	mod.link_optional("*", "httpclient_post_async", httpclient_post_async);
	mod.link_optional("*", "httpclient_post_with_headers_async", httpclient_post_with_headers_async);
	mod.link_optional("*", "httpclient_get_async", httpclient_get_async);
	mod.link_optional("*", "httpclient_download_async", httpclient_download_async);
}