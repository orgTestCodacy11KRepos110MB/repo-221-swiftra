/*
 The MIT License (MIT)

 Copyright (c) 2015 Shun Takebayashi

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
*/

import struct http4swift.HTTPRequest

public protocol Request {

    var method: String { get }
    var path: String { get }
    var proto: String { get }
    var headers: [String: String] { get }
    var body: [CChar] { get }
    var bodyString: String { get }

}

extension Request {

    public var bodyString: String {
        var buffer = body
        buffer.append(CChar(0))
        return String.fromCString(buffer) ?? ""
    }

}

public struct RawRequest: Request {

    let underlying: HTTPRequest

    init(underlying: HTTPRequest) {
        self.underlying = underlying
    }

    public var method: String {
        return underlying.method
    }

    public var path: String {
        return underlying.path
    }

    public var proto: String {
        return underlying.proto
    }

    public var headers: [String: String] {
        return underlying.headers
    }

    public var body: [CChar] {
        return underlying.body
    }

}
