From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-ust] Refactor Python agent
Date: Fri, 15 May 2015 16:14:56 +0000 (UTC)
Message-ID: <866139658.2131.1431706496751.JavaMail.zimbra__34307.8581420288$1431706583$gmane$org@efficios.com>
References: <1427846994-29691-1-git-send-email-eeppeliteloop@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1YtIGQ-0006iu-2m
 for lttng-dev@lists.lttng.org; Fri, 15 May 2015 12:15:10 -0400
In-Reply-To: <1427846994-29691-1-git-send-email-eeppeliteloop@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: lttng-dev@lists.lttng.org, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Merged, thanks!

Mathieu

----- Original Message -----
> This patch refactors the whole LTTng-UST Python agent.
> Notorious changes are:
> 
>   * Python module "lttng_agent" moved to Python package
>     "lttngust". This removes "agent" from the name, which
>     really is an implementation detail. "lttngust" is used
>     because "lttng" would clash with LTTng-tools Python
>     bindings.
>   * Python package instead of simple module. Splitting the
>     code in various modules will make future development
>     easier.
>   * Use daemon threads to make sure logging with tracing
>     support is available as long as the regular threads live,
>     while making sure that the application exits instantly when
>     its regular threads die.
>   * Create client threads and register to session daemons
>     at import time. This allows the package to be usable just
>     by importing it (no need to instanciate any specific class
>     or call any specific function).
>   * Do not use a semaphore + sleep to synchronize client threads
>     with the importing thread: use a blocking synchronized
>     queue with appropriate timeouts.
>   * Add debug statements at strategic locations, enabled by
>     setting the $LTTNG_UST_PYTHON_DEBUG environment variable
>     to 1 before importing the package.
>   * Override the default session daemon registration timeout
>     with $LTTNG_UST_PYTHON_REGISTER_TIMEOUT (ms).
>   * Override the default session daemon registration retry
>     delay with $LTTNG_UST_PYTHON_REGISTER_RETRY_DELAY (ms).
>   * Honor $LTTNG_HOME (to retrieve session daemon TCP ports).
>   * Do not use an absolute path when loading the tracepoint
>     provider shared object. Users should use the
>     $LD_LIBRARY_PATH environment variable to override the
>     default library path when running Python instead.
>   * Do not keep an event dictionary since this brings issues
>     when enabling/disabling events with the same name in
>     different sessions.
>   * Make sure the reference count does not go below 0,
>     which could happen when destroying a session which contains
>     events that are disabled already.
>   * Minor improvements to make the code more Pythonic.
> 
> Signed-off-by: Philippe Proulx <eeppeliteloop@gmail.com>
> ---
>  liblttng-ust-python-agent/Makefile.am            |  35 +-
>  liblttng-ust-python-agent/__init__.py.in         |  24 +
>  liblttng-ust-python-agent/lttng_agent.py.in      | 567
>  -----------------------
>  liblttng-ust-python-agent/lttngust/__init__.py   |  24 +
>  liblttng-ust-python-agent/lttngust/agent.py      | 389 ++++++++++++++++
>  liblttng-ust-python-agent/lttngust/cmd.py        | 178 +++++++
>  liblttng-ust-python-agent/lttngust/debug.py      |  46 ++
>  liblttng-ust-python-agent/lttngust/loghandler.py |  41 ++
>  8 files changed, 725 insertions(+), 579 deletions(-)
>  create mode 100644 liblttng-ust-python-agent/__init__.py.in
>  delete mode 100644 liblttng-ust-python-agent/lttng_agent.py.in
>  create mode 100644 liblttng-ust-python-agent/lttngust/__init__.py
>  create mode 100644 liblttng-ust-python-agent/lttngust/agent.py
>  create mode 100644 liblttng-ust-python-agent/lttngust/cmd.py
>  create mode 100644 liblttng-ust-python-agent/lttngust/debug.py
>  create mode 100644 liblttng-ust-python-agent/lttngust/loghandler.py
> 
> diff --git a/liblttng-ust-python-agent/Makefile.am
> b/liblttng-ust-python-agent/Makefile.am
> index 8b38132..869add4 100644
> --- a/liblttng-ust-python-agent/Makefile.am
> +++ b/liblttng-ust-python-agent/Makefile.am
> @@ -1,20 +1,31 @@
> +# inputs/outputs
> +LTTNGUST_PY_PACKAGE_DIR = $(srcdir)/lttngust
> +LTTNGUST_PY_PACKAGE_FILES = agent.py cmd.py debug.py loghandler.py
> +LTTNGUST_PY_PACKAGE_SRC = \
> +	$(addprefix $(LTTNGUST_PY_PACKAGE_DIR)/,$(LTTNGUST_PY_PACKAGE_FILES))
> +INIT_PY_IN = $(srcdir)/__init__.py.in
> +INIT_PY = __init__.py
>  
> -AM_CPPFLAGS = $(PYTHON_INCLUDE) -I$(top_srcdir)/include/
> -I$(top_builddir)/include/
> -AM_CFLAGS = -fno-strict-aliasing
> +# dist files
> +EXTRA_DIST = $(INIT_PY_IN) $(LTTNGUST_PY_PACKAGE_SRC)
>  
> -EXTRA_DIST = lttng_agent.py.in
> +# __init__.py with proper version string
> +all-local: $(INIT_PY)
>  
> -nodist_lttng_agent_PYTHON = lttng_agent.py
> -lttng_agentdir = $(pythondir)
> +$(INIT_PY): $(INIT_PY_IN)
> +	$(SED) "s/@LTTNG_UST_VERSION@/$(PACKAGE_VERSION)/g" < $< > $@
>  
> -lib_LTLIBRARIES = liblttng-ust-python-agent.la
> +# Python package
> +nodist_lttngust_PYTHON = $(LTTNGUST_PY_PACKAGE_SRC) $(INIT_PY)
> +lttngustdir = $(pythondir)/lttngust
>  
> -nodist_liblttng_ust_python_agent_la_SOURCES = lttng_agent.py
> +# tracepoint provider
> +AM_CPPFLAGS = $(PYTHON_INCLUDE) -I$(top_srcdir)/include/ \
> +	-I$(top_builddir)/include/
> +AM_CFLAGS = -fno-strict-aliasing
> +lib_LTLIBRARIES = liblttng-ust-python-agent.la
>  liblttng_ust_python_agent_la_SOURCES = lttng_ust_python.c lttng_ust_python.h
>  liblttng_ust_python_agent_la_LIBADD = -lc -llttng-ust \
> -		-L$(top_builddir)/liblttng-ust/.libs
> -
> -all:
> -	$(SED) 's|LIBDIR_STR|$(libdir)|g' < $(srcdir)/lttng_agent.py.in >
> lttng_agent.py
> +	-L$(top_builddir)/liblttng-ust/.libs
>  
> -CLEANFILES = lttng_agent.py
> +CLEANFILES = $(INIT_PY)
> diff --git a/liblttng-ust-python-agent/__init__.py.in
> b/liblttng-ust-python-agent/__init__.py.in
> new file mode 100644
> index 0000000..0b83d10
> --- /dev/null
> +++ b/liblttng-ust-python-agent/__init__.py.in
> @@ -0,0 +1,24 @@
> +# -*- coding: utf-8 -*-
> +#
> +# Copyright (C) 2015 - Philippe Proulx <pproulx@efficios.com>
> +#
> +# This library is free software; you can redistribute it and/or modify it
> under
> +# the terms of the GNU Lesser General Public License as published by the
> Free
> +# Software Foundation; version 2.1 of the License.
> +#
> +# This library is distributed in the hope that it will be useful, but
> WITHOUT
> +# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> FITNESS
> +# FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> more
> +# details.
> +#
> +# You should have received a copy of the GNU Lesser General Public License
> +# along with this library; if not, write to the Free Software Foundation,
> Inc.,
> +# 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
> +
> +from __future__ import unicode_literals
> +
> +# this creates the daemon threads and registers the application
> +import lttngust.agent
> +
> +
> +__version__ = '@LTTNG_UST_VERSION@'
> diff --git a/liblttng-ust-python-agent/lttng_agent.py.in
> b/liblttng-ust-python-agent/lttng_agent.py.in
> deleted file mode 100644
> index 9e8cf61..0000000
> --- a/liblttng-ust-python-agent/lttng_agent.py.in
> +++ /dev/null
> @@ -1,567 +0,0 @@
> -# -*- coding: utf-8 -*-
> -#
> -# Copyright (C) 2014 - David Goulet <dgoulet@efficios.com>
> -#
> -# This library is free software; you can redistribute it and/or modify it
> under
> -# the terms of the GNU Lesser General Public License as published by the
> Free
> -# Software Foundation; version 2.1 of the License.
> -#
> -# This library is distributed in the hope that it will be useful, but
> WITHOUT
> -# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> FITNESS
> -# FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> more
> -# details.
> -#
> -# You should have received a copy of the GNU Lesser General Public License
> -# along with this library; if not, write to the Free Software Foundation,
> Inc.,
> -# 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
> -
> -from __future__ import unicode_literals
> -
> -import ctypes
> -import errno
> -import logging
> -import os
> -import sys
> -import threading
> -import struct
> -import select
> -
> -from select import epoll, EPOLLIN, EPOLLERR, EPOLLHUP
> -from socket import *
> -from time import sleep
> -
> -__all__ = ["lttng-agent"]
> -__author__ = "David Goulet <dgoulet@efficios.com>"
> -
> -class LTTngAgent():
> -    """
> -    LTTng agent python code. A LTTng Agent is responsible to spawn two
> threads,
> -    the current UID and root session daemon. Those two threads register to
> the
> -    right daemon and handle the tracing.
> -
> -    This class needs to be instantiate once and once the init returns,
> tracing
> -    is ready to happen.
> -    """
> -
> -    SESSIOND_ADDR = "127.0.0.1"
> -    SEM_COUNT = 2
> -    # Timeout for the sempahore in seconds.
> -    SEM_TIMEOUT = 5
> -    SEM_WAIT_PERIOD = 0.2
> -
> -    def __init__(self):
> -        # Session daemon register semaphore.
> -        self.register_sem = threading.Semaphore(LTTngAgent.SEM_COUNT);
> -
> -        self.client_user = LTTngTCPClient(LTTngAgent.SESSIOND_ADDR,
> self.register_sem)
> -        self.client_user.start()
> -
> -        self.client_root = LTTngTCPClient(LTTngAgent.SESSIOND_ADDR,
> self.register_sem)
> -        self.client_root.log_handler.is_root = True
> -        self.client_root.start()
> -
> -        acquire = 0
> -        timeout = LTTngAgent.SEM_TIMEOUT
> -        while True:
> -            # Quit if timeout has reached 0 or below.
> -            if acquire == LTTngAgent.SEM_COUNT or timeout <= 0:
> -                break;
> -
> -            # Acquire semaphore for *user* thread.
> -            if not self.register_sem.acquire(False):
> -                sleep(LTTngAgent.SEM_WAIT_PERIOD)
> -                timeout -= LTTngAgent.SEM_WAIT_PERIOD
> -            else:
> -                acquire += 1
> -
> -    def __del__(self):
> -        self.destroy()
> -
> -    def destroy(self):
> -        self.client_user.destroy()
> -        self.client_user.join()
> -
> -        self.client_root.destroy()
> -        self.client_root.join()
> -
> -class LTTngCmdError(RuntimeError):
> -    """
> -    Command error thrown if an error is encountered in a command from the
> -    session daemon.
> -    """
> -
> -    def __init__(self, code):
> -        super().__init__('LTTng command error: code {}'.format(code))
> -        self._code = code
> -
> -    def get_code(self):
> -        return self._code
> -
> -class LTTngUnknownCmdError(RuntimeError):
> -    pass
> -
> -class LTTngLoggingHandler(logging.Handler):
> -    """
> -    Class handler for the Python logging API.
> -    """
> -
> -    def __init__(self):
> -        logging.Handler.__init__(self, level = logging.NOTSET)
> -
> -        # Refcount tracking how many events have been enabled. This value
> above
> -        # 0 means that the handler is attached to the root logger.
> -        self.refcount = 0
> -
> -        # Dict of enabled event. We track them so we know if it's ok to
> disable
> -        # the received event.
> -        self.enabled_events = {}
> -
> -        # Am I root ?
> -        self.is_root = False
> -
> -        # Using the logging formatter to extract the asctime only.
> -        self.log_fmt = logging.Formatter("%(asctime)s")
> -        self.setFormatter(self.log_fmt)
> -
> -        # ctypes lib for lttng-ust
> -        try:
> -            self.lttng_ust =
> ctypes.cdll.LoadLibrary("LIBDIR_STR/liblttng-ust-python-agent.so")
> -        except OSError as e:
> -            print("Unable to find libust for Python.")
> -
> -    def emit(self, record):
> -        """
> -        Fire LTTng UST tracepoint with the given record.
> -        """
> -        asctime = self.format(record)
> -
> -        self.lttng_ust.py_tracepoint(asctime.encode(),
> -                record.getMessage().encode(), record.name.encode(),
> -                record.funcName.encode(), record.lineno, record.levelno,
> -                record.thread, record.threadName.encode())
> -
> -    def enable_event(self, name):
> -        """
> -        Enable an event name which will ultimately add an handler to the
> root
> -        logger if none is present.
> -        """
> -        # Don't update the refcount if the event has been enabled prior.
> -        if name in self.enabled_events:
> -            return
> -
> -        # Get the root logger and attach our handler.
> -        root_logger = logging.getLogger()
> -        # First thing first, we need to set the root logger to the loglevel
> -        # NOTSET so we can catch everything. The default is 30.
> -        root_logger.setLevel(logging.NOTSET)
> -
> -        self.refcount += 1
> -        if self.refcount == 1:
> -            root_logger.addHandler(self)
> -
> -        self.enabled_events[name] = True
> -
> -    def disable_event(self, name):
> -        """
> -        Disable an event name which will ultimately add an handler to the
> root
> -        logger if none is present.
> -        """
> -
> -        if name not in self.enabled_events:
> -            # Event was not enabled prior, do nothing.
> -            return
> -
> -        # Get the root logger and attach our handler.
> -        root_logger = logging.getLogger()
> -
> -        self.refcount -= 1
> -        if self.refcount == 0:
> -            root_logger.removeHandler(self)
> -        del self.enabled_events[name]
> -
> -    def list_logger(self):
> -        """
> -        Return a list of logger name.
> -        """
> -        return logging.Logger.manager.loggerDict.keys()
> -
> -class LTTngSessiondCmd():
> -    """
> -    Class handling session daemon command.
> -    """
> -
> -    # Command values from the agent protocol
> -    CMD_LIST = 1
> -    CMD_ENABLE = 2
> -    CMD_DISABLE = 3
> -    CMD_REG_DONE = 4
> -
> -    # Return code
> -    CODE_SUCCESS = 1
> -    CODE_INVALID_CMD = 2
> -
> -    # Python Logger LTTng domain value taken from lttng/domain.h
> -    DOMAIN = 5
> -
> -    # Protocol version
> -    MAJOR_VERSION = 1
> -    MINOR_VERSION = 0
> -
> -    def execute(self):
> -        """
> -        This is part of the command interface. Must be implemented.
> -        """
> -        raise NotImplementedError
> -
> -class LTTngCommandReply():
> -    """
> -    Object that contains the information that should be replied to the
> session
> -    daemon after a command execution.
> -    """
> -
> -    def __init__(self, payload = None, reply = True):
> -        self.payload = payload
> -        self.reply = reply
> -
> -class LTTngCommandEnable(LTTngSessiondCmd):
> -    """
> -    Handle the enable event command from the session daemon.
> -    """
> -
> -    def __init__(self, log_handler, data):
> -        self.log_handler = log_handler
> -        # 4 bytes for loglevel and 4 bytes for loglevel_type thus 8.
> -        name_offset = 8;
> -
> -        data_size = len(data)
> -        if data_size == 0:
> -            raise LTTngCmdError(LTTngSessiondCmd.CODE_INVALID_CMD)
> -
> -        try:
> -            self.loglevel, self.loglevel_type, self.name = \
> -                    struct.unpack('>II%us' % (data_size - name_offset),
> data)
> -            # Remove trailing NULL bytes from name.
> -            self.name = self.name.decode().rstrip('\x00')
> -        except struct.error:
> -            raise LTTngCmdError(LTTngSessiondCmd.CODE_INVALID_CMD)
> -
> -    def execute(self):
> -        self.log_handler.enable_event(self.name)
> -        return LTTngCommandReply()
> -
> -class LTTngCommandDisable(LTTngSessiondCmd):
> -    """
> -    Handle the disable event command from the session daemon.
> -    """
> -
> -    def __init__(self, log_handler, data):
> -        self.log_handler = log_handler
> -
> -        data_size = len(data)
> -        if data_size == 0:
> -            raise LTTngCmdError(LTTngSessiondCmd.CODE_INVALID_CMD)
> -
> -        try:
> -            self.name = struct.unpack('>%us' % (data_size), data)[0]
> -            # Remove trailing NULL bytes from name.
> -            self.name = self.name.decode().rstrip('\x00')
> -        except struct.error:
> -            raise LTTngCmdError(LTTngSessiondCmd.CODE_INVALID_CMD)
> -
> -    def execute(self):
> -        self.log_handler.disable_event(self.name)
> -        return LTTngCommandReply()
> -
> -class LTTngCommandRegDone(LTTngSessiondCmd):
> -    """
> -    Handle register done command. This is sent back after a successful
> -    registration from the session daemon. We basically release the given
> -    semaphore so the agent can return to the caller.
> -    """
> -
> -    def __init__(self, sem):
> -        self.sem = sem
> -
> -    def execute(self):
> -        self.sem.release()
> -        return LTTngCommandReply(reply = False)
> -
> -class LTTngCommandList(LTTngSessiondCmd):
> -    """
> -    Handle the list command from the session daemon on the given socket.
> -    """
> -
> -    def __init__(self, log_handler):
> -        self.log_handler = log_handler
> -
> -    def execute(self):
> -        data_size = 0
> -        data = logger_data = bytearray()
> -
> -        loggers = self.log_handler.list_logger()
> -        # First, pack nb_event that must preceed the data.
> -        logger_data += struct.pack('>I', len(loggers))
> -
> -        # Populate payload with logger name.
> -        for logger in loggers:
> -            # Increment data size plus the NULL byte at the end of the name.
> -            data_size += len(logger) + 1
> -            # Pack logger name and NULL byte.
> -            logger_data += struct.pack('>%usB' % (len(logger)), \
> -                    bytes(bytearray(str.encode(logger))), 0)
> -
> -        # Pack uint32_t data_size followed by nb event (number of logger)
> -        data = struct.pack('>I', data_size)
> -        data += logger_data
> -        return LTTngCommandReply(payload = data)
> -
> -class LTTngTCPClient(threading.Thread):
> -    """
> -    TCP client that register and receives command from the session daemon.
> -    """
> -
> -    SYSTEM_PORT_FILE = "/var/run/lttng/agent.port"
> -    USER_PORT_FILE = os.path.join(os.path.expanduser("~"),
> ".lttng/agent.port")
> -
> -    # The time in seconds this client should wait before trying again to
> -    # register back to the session daemon.
> -    WAIT_TIME = 3
> -
> -    def __init__(self, host, sem):
> -        threading.Thread.__init__(self)
> -
> -        # Which host to connect to. The port is fetch dynamically.
> -        self.sessiond_host = host
> -
> -        # The session daemon register done semaphore. Needs to be released
> when
> -        # receiving a CMD_REG_DONE command.
> -        self.register_sem = sem
> -        self.register_sem.acquire()
> -
> -        # Indicate that we have to quit thus stop the main loop.
> -        self.quit_flag = False
> -        # Quit pipe. The thread poll on it to know when to quit.
> -        self.quit_pipe = os.pipe()
> -
> -        # Socket on which we communicate with the session daemon.
> -        self.sessiond_sock = None
> -        # LTTng Logging Handler
> -        self.log_handler = LTTngLoggingHandler()
> -
> -    def cleanup_socket(self, epfd = None):
> -        # Ease our life a bit.
> -        sock = self.sessiond_sock
> -        if not sock:
> -            return
> -
> -        try:
> -            if epfd is not None:
> -                epfd.unregister(sock)
> -            sock.shutdown(SHUT_RDWR)
> -            sock.close()
> -        except select.error:
> -            # Cleanup fail, we can't do anything much...
> -            pass
> -        except IOError:
> -            pass
> -
> -        self.sessiond_sock = None
> -
> -    def destroy(self):
> -        self.quit_flag = True
> -        try:
> -            fp = os.fdopen(self.quit_pipe[1], 'w')
> -            fp.write("42")
> -            fp.close()
> -        except OSError as e:
> -            pass
> -
> -    def register(self):
> -        """
> -        Register to session daemon using the previously connected socket of
> the
> -        class.
> -
> -        Command ABI:
> -            uint32 domain
> -            uint32 pid
> -        """
> -        data = struct.pack('>IIII', LTTngSessiondCmd.DOMAIN, os.getpid(), \
> -                LTTngSessiondCmd.MAJOR_VERSION,
> LTTngSessiondCmd.MINOR_VERSION)
> -        self.sessiond_sock.send(data)
> -
> -    def run(self):
> -        """
> -        Start the TCP client thread by registering to the session daemon and
> polling
> -        on that socket for commands.
> -        """
> -
> -        epfd = epoll()
> -        epfd.register(self.quit_pipe[0], EPOLLIN)
> -
> -        # Main loop to handle session daemon command and disconnection.
> -        while not self.quit_flag:
> -            try:
> -                # First, connect to the session daemon.
> -                self.connect_sessiond()
> -
> -                # Register to session daemon after a successful connection.
> -                self.register()
> -                # Add registered socket to poll set.
> -                epfd.register(self.sessiond_sock, EPOLLIN | EPOLLERR |
> EPOLLHUP)
> -
> -                self.quit_flag = self.wait_cmd(epfd)
> -            except IOError as e:
> -                # Whatever happens here, we have to close down everything
> and
> -                # retry to connect to the session daemon since either the
> -                # socket is closed or invalid data was sent.
> -                self.cleanup_socket(epfd)
> -                self.register_sem.release()
> -                sleep(LTTngTCPClient.WAIT_TIME)
> -                continue
> -
> -        self.cleanup_socket(epfd)
> -        os.close(self.quit_pipe[0])
> -        epfd.close()
> -
> -    def recv_header(self, sock):
> -        """
> -        Receive the command header from the given socket. Set the internal
> -        state of this object with the header data.
> -
> -        Header ABI is defined like this:
> -            uint64 data_size
> -            uint32 cmd
> -            uint32 cmd_version
> -        """
> -        s_pack = struct.Struct('>QII')
> -
> -        pack_data = sock.recv(s_pack.size)
> -        data_received = len(pack_data)
> -        if data_received == 0:
> -            raise IOError(errno.ESHUTDOWN)
> -
> -        try:
> -            return s_pack.unpack(pack_data)
> -        except struct.error:
> -            raise IOError(errno.EINVAL)
> -
> -    def create_command(self, cmd_type, version, data):
> -        """
> -        Return the right command object using the given command type. The
> -        command version is unused since we only have once for now.
> -        """
> -
> -        cmd_dict = {
> -            LTTngSessiondCmd.CMD_LIST: \
> -                    lambda: LTTngCommandList(self.log_handler),
> -            LTTngSessiondCmd.CMD_ENABLE: \
> -                    lambda: LTTngCommandEnable(self.log_handler, data),
> -            LTTngSessiondCmd.CMD_DISABLE: \
> -                    lambda: LTTngCommandDisable(self.log_handler, data),
> -            LTTngSessiondCmd.CMD_REG_DONE: \
> -                    lambda: LTTngCommandRegDone(self.register_sem),
> -        }
> -
> -        if cmd_type in cmd_dict:
> -            return cmd_dict[cmd_type]()
> -        else:
> -            raise LTTngUnknownCmdError()
> -
> -    def pack_code(self, code):
> -        return struct.pack('>I', code)
> -
> -    def handle_command(self, data, cmd_type, cmd_version):
> -        """
> -        Handle the given command type with the received payload. This
> function
> -        sends back data to the session daemon using to the return value of
> the
> -        command.
> -        """
> -        payload = bytearray()
> -
> -        try:
> -            cmd = self.create_command(cmd_type, cmd_version, data)
> -            cmd_reply = cmd.execute()
> -            # Set success code in data
> -            payload += self.pack_code(LTTngSessiondCmd.CODE_SUCCESS)
> -            if cmd_reply.payload is not None:
> -                payload += cmd_reply.payload
> -        except LTTngCmdError as e:
> -            # Set error code in payload
> -            payload += self.pack_code(e.get_code())
> -        except LTTngUnknownCmdError:
> -            # Set error code in payload
> -            payload += self.pack_code(LTTngSessiondCmd.CODE_INVALID_CMD)
> -
> -        # Send response only if asked for.
> -        if cmd_reply.reply:
> -            self.sessiond_sock.send(payload)
> -
> -    def wait_cmd(self, epfd):
> -        """
> -        """
> -
> -        while True:
> -            try:
> -                # Poll on socket for command.
> -                events = epfd.poll()
> -            except select.error as e:
> -                raise IOError(e.errno, e.message)
> -
> -            for fileno, event in events:
> -                if fileno == self.quit_pipe[0]:
> -                    return True
> -                elif event & (EPOLLERR | EPOLLHUP):
> -                    raise IOError(errno.ESHUTDOWN)
> -                elif event & EPOLLIN:
> -                    data = bytearray()
> -
> -                    data_size, cmd, cmd_version =
> self.recv_header(self.sessiond_sock)
> -                    if data_size:
> -                        data += self.sessiond_sock.recv(data_size)
> -
> -                    self.handle_command(data, cmd, cmd_version)
> -                else:
> -                    raise IOError(errno.ESHUTDOWN)
> -
> -    def get_port_from_file(self, path):
> -        """
> -        Open the session daemon agent port file and returns the value. If
> none
> -        found, 0 is returned.
> -        """
> -
> -        # By default, the port is set to 0 so if we can not find the agent
> port
> -        # file simply don't try to connect. A value set to 0 indicates that.
> -        port = 0
> -
> -        try:
> -            f = open(path, "r")
> -            r_port = int(f.readline())
> -            if r_port > 0 or r_port <= 65535:
> -                port = r_port
> -            f.close()
> -        except IOError as e:
> -            pass
> -        except ValueError as e:
> -            pass
> -
> -        return port
> -
> -    def connect_sessiond(self):
> -        """
> -        Connect sessiond_sock to running session daemon using the port file.
> -        """
> -        # Create session daemon TCP socket
> -        if not self.sessiond_sock:
> -            self.sessiond_sock = socket(AF_INET, SOCK_STREAM)
> -
> -        if self.log_handler.is_root:
> -            port = self.get_port_from_file(LTTngTCPClient.SYSTEM_PORT_FILE)
> -        else:
> -            port = self.get_port_from_file(LTTngTCPClient.USER_PORT_FILE)
> -
> -        # No session daemon available
> -        if port == 0:
> -            raise IOError(errno.ECONNREFUSED)
> -
> -        # Can raise an IOError so caller must catch it.
> -        self.sessiond_sock.connect((self.sessiond_host, port))
> diff --git a/liblttng-ust-python-agent/lttngust/__init__.py
> b/liblttng-ust-python-agent/lttngust/__init__.py
> new file mode 100644
> index 0000000..5236bc8
> --- /dev/null
> +++ b/liblttng-ust-python-agent/lttngust/__init__.py
> @@ -0,0 +1,24 @@
> +# -*- coding: utf-8 -*-
> +#
> +# Copyright (C) 2015 - Philippe Proulx <pproulx@efficios.com>
> +#
> +# This library is free software; you can redistribute it and/or modify it
> under
> +# the terms of the GNU Lesser General Public License as published by the
> Free
> +# Software Foundation; version 2.1 of the License.
> +#
> +# This library is distributed in the hope that it will be useful, but
> WITHOUT
> +# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> FITNESS
> +# FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> more
> +# details.
> +#
> +# You should have received a copy of the GNU Lesser General Public License
> +# along with this library; if not, write to the Free Software Foundation,
> Inc.,
> +# 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
> +
> +from __future__ import unicode_literals
> +
> +# this creates the daemon threads and registers the application
> +import lttngust.agent
> +
> +
> +__version__ = '2.6.0-rc1'
> diff --git a/liblttng-ust-python-agent/lttngust/agent.py
> b/liblttng-ust-python-agent/lttngust/agent.py
> new file mode 100644
> index 0000000..8ec26cd
> --- /dev/null
> +++ b/liblttng-ust-python-agent/lttngust/agent.py
> @@ -0,0 +1,389 @@
> +# -*- coding: utf-8 -*-
> +#
> +# Copyright (C) 2015 - Philippe Proulx <pproulx@efficios.com>
> +# Copyright (C) 2014 - David Goulet <dgoulet@efficios.com>
> +#
> +# This library is free software; you can redistribute it and/or modify it
> under
> +# the terms of the GNU Lesser General Public License as published by the
> Free
> +# Software Foundation; version 2.1 of the License.
> +#
> +# This library is distributed in the hope that it will be useful, but
> WITHOUT
> +# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> FITNESS
> +# FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> more
> +# details.
> +#
> +# You should have received a copy of the GNU Lesser General Public License
> +# along with this library; if not, write to the Free Software Foundation,
> Inc.,
> +# 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
> +
> +from __future__ import unicode_literals
> +from __future__ import print_function
> +from __future__ import division
> +import lttngust.debug as dbg
> +import lttngust.loghandler
> +import lttngust.cmd
> +from io import open
> +import threading
> +import logging
> +import socket
> +import time
> +import sys
> +import os
> +
> +
> +try:
> +    # Python 2
> +    import Queue as queue
> +except ImportError:
> +    # Python 3
> +    import queue
> +
> +
> +_PROTO_DOMAIN = 5
> +_PROTO_MAJOR = 1
> +_PROTO_MINOR = 0
> +
> +
> +def _get_env_value_ms(key, default_s):
> +    try:
> +        val = int(os.getenv(key, default_s * 1000)) / 1000
> +    except:
> +        val = -1
> +
> +    if val < 0:
> +        fmt = 'invalid ${} value; {} seconds will be used'
> +        dbg._pwarning(fmt.format(key, default_s))
> +        val = default_s
> +
> +    return val
> +
> +
> +_REG_TIMEOUT = _get_env_value_ms('LTTNG_UST_PYTHON_REGISTER_TIMEOUT', 5)
> +_RETRY_REG_DELAY =
> _get_env_value_ms('LTTNG_UST_PYTHON_REGISTER_RETRY_DELAY', 3)
> +
> +
> +class _TcpClient(object):
> +    def __init__(self, name, host, port, reg_queue):
> +        super(self.__class__, self).__init__()
> +        self._name = name
> +        self._host = host
> +        self._port = port
> +
> +        try:
> +            self._log_handler = lttngust.loghandler._Handler()
> +        except (OSError) as e:
> +            dbg._pwarning('cannot load library: {}'.format(e))
> +            raise e
> +
> +        self._root_logger = logging.getLogger()
> +        self._root_logger.setLevel(logging.NOTSET)
> +        self._ref_count = 0
> +        self._sessiond_sock = None
> +        self._reg_queue = reg_queue
> +        self._server_cmd_handlers = {
> +            lttngust.cmd._ServerCmdRegistrationDone:
> self._handle_server_cmd_reg_done,
> +            lttngust.cmd._ServerCmdEnable: self._handle_server_cmd_enable,
> +            lttngust.cmd._ServerCmdDisable: self._handle_server_cmd_disable,
> +            lttngust.cmd._ServerCmdList: self._handle_server_cmd_list,
> +        }
> +
> +    def _debug(self, msg):
> +        return 'client "{}": {}'.format(self._name, msg)
> +
> +    def run(self):
> +        while True:
> +            try:
> +                # connect to the session daemon
> +                dbg._pdebug(self._debug('connecting to session daemon'))
> +                self._connect_to_sessiond()
> +
> +                # register to the session daemon after a successful
> connection
> +                dbg._pdebug(self._debug('registering to session daemon'))
> +                self._register()
> +
> +                # wait for commands from the session daemon
> +                self._wait_server_cmd()
> +            except (Exception) as e:
> +                # Whatever happens here, we have to close the socket and
> +                # retry to connect to the session daemon since either
> +                # the socket was closed, a network timeout occured, or
> +                # invalid data was received.
> +                dbg._pdebug(self._debug('got exception: {}'.format(e)))
> +                self._cleanup_socket()
> +                dbg._pdebug(self._debug('sleeping for {}
> s'.format(_RETRY_REG_DELAY)))
> +                time.sleep(_RETRY_REG_DELAY)
> +
> +    def _recv_server_cmd_header(self):
> +        data =
> self._sessiond_sock.recv(lttngust.cmd._SERVER_CMD_HEADER_SIZE)
> +
> +        if not data:
> +            dbg._pdebug(self._debug('received empty server command header'))
> +            return None
> +
> +        assert(len(data) == lttngust.cmd._SERVER_CMD_HEADER_SIZE)
> +        dbg._pdebug(self._debug('received server command header ({}
> bytes)'.format(len(data))))
> +
> +        return lttngust.cmd._server_cmd_header_from_data(data)
> +
> +    def _recv_server_cmd(self):
> +        server_cmd_header = self._recv_server_cmd_header()
> +
> +        if server_cmd_header is None:
> +            return None
> +
> +        dbg._pdebug(self._debug('server command header: data size: {}
> bytes'.format(server_cmd_header.data_size)))
> +        dbg._pdebug(self._debug('server command header: command ID:
> {}'.format(server_cmd_header.cmd_id)))
> +        dbg._pdebug(self._debug('server command header: command version:
> {}'.format(server_cmd_header.cmd_version)))
> +        data = bytes()
> +
> +        if server_cmd_header.data_size > 0:
> +            data = self._sessiond_sock.recv(server_cmd_header.data_size)
> +            assert(len(data) == server_cmd_header.data_size)
> +
> +        return lttngust.cmd._server_cmd_from_data(server_cmd_header, data)
> +
> +    def _send_cmd_reply(self, cmd_reply):
> +        data = cmd_reply.get_data()
> +        dbg._pdebug(self._debug('sending command reply ({}
> bytes)'.format(len(data))))
> +        self._sessiond_sock.sendall(data)
> +
> +    def _handle_server_cmd_reg_done(self, server_cmd):
> +        dbg._pdebug(self._debug('got "registration done" server command'))
> +
> +        if self._reg_queue is not None:
> +            dbg._pdebug(self._debug('notifying _init_threads()'))
> +
> +            try:
> +                self._reg_queue.put(True)
> +            except (Exception) as e:
> +                # read side could be closed by now; ignore it
> +                pass
> +
> +            self._reg_queue = None
> +
> +    def _handle_server_cmd_enable(self, server_cmd):
> +        dbg._pdebug(self._debug('got "enable" server command'))
> +        self._ref_count += 1
> +
> +        if self._ref_count == 1:
> +            dbg._pdebug(self._debug('adding our handler to the root
> logger'))
> +            self._root_logger.addHandler(self._log_handler)
> +
> +        dbg._pdebug(self._debug('ref count is {}'.format(self._ref_count)))
> +
> +        return lttngust.cmd._ClientCmdReplyEnable()
> +
> +    def _handle_server_cmd_disable(self, server_cmd):
> +        dbg._pdebug(self._debug('got "disable" server command'))
> +        self._ref_count -= 1
> +
> +        if self._ref_count < 0:
> +            # disable command could be sent again when a session is
> destroyed
> +            self._ref_count = 0
> +
> +        if self._ref_count == 0:
> +            dbg._pdebug(self._debug('removing our handler from the root
> logger'))
> +            self._root_logger.removeHandler(self._log_handler)
> +
> +        dbg._pdebug(self._debug('ref count is {}'.format(self._ref_count)))
> +
> +        return lttngust.cmd._ClientCmdReplyDisable()
> +
> +    def _handle_server_cmd_list(self, server_cmd):
> +        dbg._pdebug(self._debug('got "list" server command'))
> +        names = logging.Logger.manager.loggerDict.keys()
> +        dbg._pdebug(self._debug('found {} loggers'.format(len(names))))
> +        cmd_reply = lttngust.cmd._ClientCmdReplyList(names=names)
> +
> +        return cmd_reply
> +
> +    def _handle_server_cmd(self, server_cmd):
> +        cmd_reply = None
> +
> +        if server_cmd is None:
> +            dbg._pdebug(self._debug('bad server command'))
> +            status = lttngust.cmd._CLIENT_CMD_REPLY_STATUS_INVALID_CMD
> +            cmd_reply = lttngust.cmd._ClientCmdReply(status)
> +        elif type(server_cmd) in self._server_cmd_handlers:
> +            cmd_reply =
> self._server_cmd_handlers[type(server_cmd)](server_cmd)
> +        else:
> +            dbg._pdebug(self._debug('unknown server command'))
> +            status = lttngust.cmd._CLIENT_CMD_REPLY_STATUS_INVALID_CMD
> +            cmd_reply = lttngust.cmd._ClientCmdReply(status)
> +
> +        if cmd_reply is not None:
> +            self._send_cmd_reply(cmd_reply)
> +
> +    def _wait_server_cmd(self):
> +        while True:
> +            try:
> +                server_cmd = self._recv_server_cmd()
> +            except socket.timeout:
> +                # simply retry here; the protocol has no KA and we could
> +                # wait for hours
> +                continue
> +
> +            self._handle_server_cmd(server_cmd)
> +
> +    def _cleanup_socket(self):
> +        try:
> +            self._sessiond_sock.shutdown(socket.SHUT_RDWR)
> +            self._sessiond_sock.close()
> +        except:
> +            pass
> +
> +        self._sessiond_sock = None
> +
> +    def _connect_to_sessiond(self):
> +        # create session daemon TCP socket
> +        if self._sessiond_sock is None:
> +            self._sessiond_sock = socket.socket(socket.AF_INET,
> +                                                socket.SOCK_STREAM)
> +
> +        # Use str(self._host) here. Since this host could be a string
> +        # literal, and since we're importing __future__.unicode_literals,
> +        # we want to make sure the host is a native string in Python 2.
> +        # This avoids an indirect module import (unicode module to
> +        # decode the unicode string, eventually imported by the
> +        # socket module if needed), which is not allowed in a thread
> +        # directly created by a module in Python 2 (our case).
> +        #
> +        # tl;dr: Do NOT remove str() here, or this call in Python 2
> +        # _will_ block on an interpreter's mutex until the waiting
> +        # register queue timeouts.
> +        self._sessiond_sock.connect((str(self._host), self._port))
> +
> +    def _register(self):
> +        cmd = lttngust.cmd._ClientRegisterCmd(_PROTO_DOMAIN, os.getpid(),
> +                                              _PROTO_MAJOR, _PROTO_MINOR)
> +        data = cmd.get_data()
> +        self._sessiond_sock.sendall(data)
> +
> +
> +def _get_port_from_file(path):
> +    port = None
> +    dbg._pdebug('reading port from file "{}"'.format(path))
> +
> +    try:
> +        f = open(path)
> +        r_port = int(f.readline())
> +        f.close()
> +
> +        if r_port > 0 or r_port <= 65535:
> +            port = r_port
> +    except:
> +        pass
> +
> +    return port
> +
> +
> +def _get_user_home_path():
> +    # $LTTNG_HOME overrides $HOME if it exists
> +    return os.getenv('LTTNG_HOME', os.path.expanduser('~'))
> +
> +
> +_initialized = False
> +_SESSIOND_HOST = '127.0.0.1'
> +
> +
> +def _client_thread_target(name, port, reg_queue):
> +    dbg._pdebug('creating client "{}" using TCP port {}'.format(name, port))
> +    client = _TcpClient(name, _SESSIOND_HOST, port, reg_queue)
> +    dbg._pdebug('starting client "{}"'.format(name))
> +    client.run()
> +
> +
> +def _init_threads():
> +    global _initialized
> +
> +    dbg._pdebug('entering')
> +
> +    if _initialized:
> +        dbg._pdebug('agent is already initialized')
> +        return
> +
> +    # This makes sure that the appropriate modules for encoding and
> +    # decoding strings/bytes are imported now, since no import should
> +    # happen within a thread at import time (our case).
> +    'lttng'.encode().decode()
> +
> +    _initialized = True
> +    sys_port = _get_port_from_file('/var/run/lttng/agent.port')
> +    user_port_file = os.path.join(_get_user_home_path(), '.lttng',
> 'agent.port')
> +    user_port = _get_port_from_file(user_port_file)
> +    reg_queue = queue.Queue()
> +    reg_expecting = 0
> +
> +    dbg._pdebug('system session daemon port: {}'.format(sys_port))
> +    dbg._pdebug('user session daemon port: {}'.format(user_port))
> +
> +    try:
> +        if sys_port is not None:
> +            dbg._pdebug('creating system client thread')
> +            t = threading.Thread(target=_client_thread_target,
> +                                 args=('system', sys_port, reg_queue))
> +            t.name = 'system'
> +            t.daemon = True
> +            t.start()
> +            dbg._pdebug('created and started system client thread')
> +            reg_expecting += 1
> +
> +        if user_port is not None:
> +            dbg._pdebug('creating user client thread')
> +            t = threading.Thread(target=_client_thread_target,
> +                                 args=('user', user_port, reg_queue))
> +            t.name = 'user'
> +            t.daemon = True
> +            t.start()
> +            dbg._pdebug('created and started user client thread')
> +            reg_expecting += 1
> +    except:
> +        # cannot create threads for some reason; stop this initialization
> +        dbg._pwarning('cannot create client threads')
> +        return
> +
> +    if reg_expecting == 0:
> +        # early exit: looks like there's not even one valid port
> +        dbg._pwarning('no valid LTTng session daemon port found (is the
> session daemon started?)')
> +        return
> +
> +    cur_timeout = _REG_TIMEOUT
> +
> +    # We block here to make sure the agent is properly registered to
> +    # the session daemon. If we timeout, the client threads will still
> +    # continue to try to connect and register to the session daemon,
> +    # but there is no guarantee that all following logging statements
> +    # will make it to LTTng-UST.
> +    #
> +    # When a client thread receives a "registration done" confirmation
> +    # from the session daemon it's connected to, it puts True in
> +    # reg_queue.
> +    while True:
> +        try:
> +            dbg._pdebug('waiting for registration done (expecting {},
> timeout is {} s)'.format(reg_expecting,
> +
> cur_timeout))
> +            t1 = time.clock()
> +            reg_queue.get(timeout=cur_timeout)
> +            t2 = time.clock()
> +            reg_expecting -= 1
> +            dbg._pdebug('unblocked')
> +
> +            if reg_expecting == 0:
> +                # done!
> +                dbg._pdebug('successfully registered to session daemon(s)')
> +                break
> +
> +            cur_timeout -= (t2 - t1)
> +
> +            if cur_timeout <= 0:
> +                # timeout
> +                dbg._pdebug('ran out of time')
> +                break
> +        except queue.Empty:
> +            dbg._pdebug('ran out of time')
> +            break
> +
> +    dbg._pdebug('leaving')
> +
> +
> +_init_threads()
> diff --git a/liblttng-ust-python-agent/lttngust/cmd.py
> b/liblttng-ust-python-agent/lttngust/cmd.py
> new file mode 100644
> index 0000000..fe180fa
> --- /dev/null
> +++ b/liblttng-ust-python-agent/lttngust/cmd.py
> @@ -0,0 +1,178 @@
> +# -*- coding: utf-8 -*-
> +#
> +# Copyright (C) 2015 - Philippe Proulx <pproulx@efficios.com>
> +# Copyright (C) 2014 - David Goulet <dgoulet@efficios.com>
> +#
> +# This library is free software; you can redistribute it and/or modify it
> under
> +# the terms of the GNU Lesser General Public License as published by the
> Free
> +# Software Foundation; version 2.1 of the License.
> +#
> +# This library is distributed in the hope that it will be useful, but
> WITHOUT
> +# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> FITNESS
> +# FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> more
> +# details.
> +#
> +# You should have received a copy of the GNU Lesser General Public License
> +# along with this library; if not, write to the Free Software Foundation,
> Inc.,
> +# 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
> +
> +from __future__ import unicode_literals
> +import lttngust.debug as dbg
> +import struct
> +
> +
> +# server command header
> +_server_cmd_header_struct = struct.Struct('>QII')
> +
> +
> +# server command header size
> +_SERVER_CMD_HEADER_SIZE = _server_cmd_header_struct.size
> +
> +
> +class _ServerCmdHeader(object):
> +    def __init__(self, data_size, cmd_id, cmd_version):
> +        self.data_size = data_size
> +        self.cmd_id = cmd_id
> +        self.cmd_version = cmd_version
> +
> +
> +def _server_cmd_header_from_data(data):
> +    try:
> +        data_size, cmd_id, cmd_version =
> _server_cmd_header_struct.unpack(data)
> +    except (Exception) as e:
> +        dbg._pdebug('cannot decode command header: {}'.format(e))
> +        return None
> +
> +    return _ServerCmdHeader(data_size, cmd_id, cmd_version)
> +
> +
> +class _ServerCmd(object):
> +    def __init__(self, header):
> +        self.header = header
> +
> +    @classmethod
> +    def from_data(cls, header, data):
> +        raise NotImplementedError()
> +
> +
> +class _ServerCmdList(_ServerCmd):
> +    @classmethod
> +    def from_data(cls, header, data):
> +        return cls(header)
> +
> +
> +class _ServerCmdEnable(_ServerCmd):
> +    _NAME_OFFSET = 8
> +    _loglevel_struct = struct.Struct('>II')
> +
> +    def __init__(self, header, loglevel, loglevel_type, name):
> +        super(self.__class__, self).__init__(header)
> +        self.loglevel = loglevel
> +        self.loglevel_type = loglevel_type
> +        self.name = name
> +
> +    @classmethod
> +    def from_data(cls, header, data):
> +        try:
> +            loglevel, loglevel_type = cls._loglevel_struct.unpack_from(data)
> +            data_name = data[cls._loglevel_struct.size:]
> +            name = data_name.rstrip(b'\0').decode()
> +
> +            return cls(header, loglevel, loglevel_type, name)
> +        except (Exception) as e:
> +            dbg._pdebug('cannot decode enable command: {}'.format(e))
> +            return None
> +
> +
> +class _ServerCmdDisable(_ServerCmd):
> +    def __init__(self, header, name):
> +        super(self.__class__, self).__init__(header)
> +        self.name = name
> +
> +    @classmethod
> +    def from_data(cls, header, data):
> +        try:
> +            name = data.rstrip(b'\0').decode()
> +
> +            return cls(header, name)
> +        except (Exception) as e:
> +            dbg._pdebug('cannot decode disable command: {}'.format(e))
> +            return None
> +
> +
> +class _ServerCmdRegistrationDone(_ServerCmd):
> +    @classmethod
> +    def from_data(cls, header, data):
> +        return cls(header)
> +
> +
> +_SERVER_CMD_ID_TO_SERVER_CMD = {
> +    1: _ServerCmdList,
> +    2: _ServerCmdEnable,
> +    3: _ServerCmdDisable,
> +    4: _ServerCmdRegistrationDone,
> +}
> +
> +
> +def _server_cmd_from_data(header, data):
> +    if header.cmd_id not in _SERVER_CMD_ID_TO_SERVER_CMD:
> +        return None
> +
> +    return _SERVER_CMD_ID_TO_SERVER_CMD[header.cmd_id].from_data(header,
> data)
> +
> +
> +_CLIENT_CMD_REPLY_STATUS_SUCCESS = 1
> +_CLIENT_CMD_REPLY_STATUS_INVALID_CMD = 2
> +
> +
> +class _ClientCmdReplyHeader(object):
> +    _payload_struct = struct.Struct('>I')
> +
> +    def __init__(self, status_code=_CLIENT_CMD_REPLY_STATUS_SUCCESS):
> +        self.status_code = status_code
> +
> +    def get_data(self):
> +        return self._payload_struct.pack(self.status_code)
> +
> +
> +class _ClientCmdReplyEnable(_ClientCmdReplyHeader):
> +    pass
> +
> +
> +class _ClientCmdReplyDisable(_ClientCmdReplyHeader):
> +    pass
> +
> +
> +class _ClientCmdReplyList(_ClientCmdReplyHeader):
> +    _nb_events_struct = struct.Struct('>I')
> +    _data_size_struct = struct.Struct('>I')
> +
> +    def __init__(self, names, status_code=_CLIENT_CMD_REPLY_STATUS_SUCCESS):
> +        super(self.__class__, self).__init__(status_code)
> +        self.names = names
> +
> +    def get_data(self):
> +        upper_data = super(self.__class__, self).get_data()
> +        nb_events_data = self._nb_events_struct.pack(len(self.names))
> +        names_data = bytes()
> +
> +        for name in self.names:
> +            names_data += name.encode() + b'\0'
> +
> +        data_size_data = self._data_size_struct.pack(len(names_data))
> +
> +        return upper_data + data_size_data + nb_events_data + names_data
> +
> +
> +class _ClientRegisterCmd(object):
> +    _payload_struct = struct.Struct('>IIII')
> +
> +    def __init__(self, domain, pid, major, minor):
> +        self.domain = domain
> +        self.pid = pid
> +        self.major = major
> +        self.minor = minor
> +
> +    def get_data(self):
> +        return self._payload_struct.pack(self.domain, self.pid, self.major,
> +                                         self.minor)
> diff --git a/liblttng-ust-python-agent/lttngust/debug.py
> b/liblttng-ust-python-agent/lttngust/debug.py
> new file mode 100644
> index 0000000..6f0e81b
> --- /dev/null
> +++ b/liblttng-ust-python-agent/lttngust/debug.py
> @@ -0,0 +1,46 @@
> +# -*- coding: utf-8 -*-
> +#
> +# Copyright (C) 2015 - Philippe Proulx <pproulx@efficios.com>
> +#
> +# This library is free software; you can redistribute it and/or modify it
> under
> +# the terms of the GNU Lesser General Public License as published by the
> Free
> +# Software Foundation; version 2.1 of the License.
> +#
> +# This library is distributed in the hope that it will be useful, but
> WITHOUT
> +# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> FITNESS
> +# FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> more
> +# details.
> +#
> +# You should have received a copy of the GNU Lesser General Public License
> +# along with this library; if not, write to the Free Software Foundation,
> Inc.,
> +# 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
> +
> +from __future__ import unicode_literals, print_function
> +import time
> +import sys
> +import os
> +
> +
> +_ENABLE_DEBUG = os.getenv('LTTNG_UST_PYTHON_DEBUG', '0') == '1'
> +
> +
> +if _ENABLE_DEBUG:
> +    import inspect
> +
> +    def _pwarning(msg):
> +        fname = inspect.stack()[1][3]
> +        fmt = '[{:.6f}] LTTng-UST warning: {}(): {}'
> +        print(fmt.format(time.clock(), fname, msg), file=sys.stderr)
> +
> +    def _pdebug(msg):
> +        fname = inspect.stack()[1][3]
> +        fmt = '[{:.6f}] LTTng-UST debug: {}(): {}'
> +        print(fmt.format(time.clock(), fname, msg), file=sys.stderr)
> +
> +    _pdebug('debug is enabled')
> +else:
> +    def _pwarning(msg):
> +        pass
> +
> +    def _pdebug(msg):
> +        pass
> diff --git a/liblttng-ust-python-agent/lttngust/loghandler.py
> b/liblttng-ust-python-agent/lttngust/loghandler.py
> new file mode 100644
> index 0000000..e82cf5c
> --- /dev/null
> +++ b/liblttng-ust-python-agent/lttngust/loghandler.py
> @@ -0,0 +1,41 @@
> +# -*- coding: utf-8 -*-
> +#
> +# Copyright (C) 2015 - Philippe Proulx <pproulx@efficios.com>
> +# Copyright (C) 2014 - David Goulet <dgoulet@efficios.com>
> +#
> +# This library is free software; you can redistribute it and/or modify it
> under
> +# the terms of the GNU Lesser General Public License as published by the
> Free
> +# Software Foundation; version 2.1 of the License.
> +#
> +# This library is distributed in the hope that it will be useful, but
> WITHOUT
> +# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> FITNESS
> +# FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for
> more
> +# details.
> +#
> +# You should have received a copy of the GNU Lesser General Public License
> +# along with this library; if not, write to the Free Software Foundation,
> Inc.,
> +# 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301 USA
> +
> +from __future__ import unicode_literals
> +import logging
> +import ctypes
> +
> +
> +class _Handler(logging.Handler):
> +    _LIB_NAME = 'liblttng-ust-python-agent.so'
> +
> +    def __init__(self):
> +        super(self.__class__, self).__init__(level=logging.NOTSET)
> +        self.setFormatter(logging.Formatter('%(asctime)s'))
> +
> +        # will raise if library is not found: caller should catch
> +        self.agent_lib = ctypes.cdll.LoadLibrary(_Handler._LIB_NAME)
> +
> +    def emit(self, record):
> +        self.agent_lib.py_tracepoint(self.format(record).encode(),
> +                                     record.getMessage().encode(),
> +                                     record.name.encode(),
> +                                     record.funcName.encode(),
> +                                     record.lineno, record.levelno,
> +                                     record.thread,
> +                                     record.threadName.encode())
> --
> 2.3.0
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
