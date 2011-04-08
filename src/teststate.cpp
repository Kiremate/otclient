/* The MIT License
 *
 * Copyright (c) 2010 OTClient, https://github.com/edubart/otclient
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */


#include "teststate.h"
#include "framework/graphics.h"
#include "framework/logger.h"
#include "framework/engine.h"
#include "framework/input.h"

#include "framework/net/connections.h"

void TestState::onEnter()
{
    m_connection = g_connections.createConnection();
    m_connection->setCallback([this]() {
        this->onConnect();
    });

    m_connection->connect("www.google.com.br", 80);
}

void TestState::onConnect()
{
    if(m_connection->isConnected()){
        logInfo("Connected.");
    }
    else{
        logError("Not connected: %d", m_connection->getLastError().message().c_str());
    }
}

void TestState::onLeave()
{

}

void TestState::onClose()
{
    g_engine.stop();
}

void TestState::onInputEvent(InputEvent* event)
{

}

void TestState::render()
{

}

void TestState::update(int ticks, int elapsedTicks)
{

}
