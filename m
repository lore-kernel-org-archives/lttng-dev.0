From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Subject: Re: Out of Tree Kernel Module
Date: Wed, 21 Jan 2015 21:28:26 +0000
Message-ID: <1421875706.22804.6.camel__14266.0296791748$1421875745$gmane$org@c00941>
References: <1421873728.21263.3.camel@c00941>
 <CAB4xu_3HiokfZFZsanRBK1bcNv7wxMn2P27yme3H84wxPhtF5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from echo.usurf.usu.edu ([129.123.194.129])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Jonathan.Haws@sdl.usu.edu>) id 1YE2pE-0003RW-Qq
 for lttng-dev@lists.lttng.org; Wed, 21 Jan 2015 16:28:37 -0500
In-Reply-To: <CAB4xu_3HiokfZFZsanRBK1bcNv7wxMn2P27yme3H84wxPhtF5w@mail.gmail.com>
Content-Language: en-US
Content-ID: <09C85DD35464BE4E8447BA3CBFE6122E@sdl.usu.edu>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "eeppeliteloop@gmail.com" <eeppeliteloop@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

> Did you try the procedure described here?
> <http://lttng.org/docs/#doc-instrumenting-out-of-tree-linux-kernel>

Yes, I have been following that.  However, that talks about changes to
the probe file, but doesn't address anything about the actual module
being instrumented.  There isn't any information about where to put your
tracepoint definitions header for an out-of-tree module.

Does the tracepoint definition still have to reside in the kernel
sources?  I hope not - hopefully there is a way to point the module
Makefiles to where my tracepoint files actually are.

Thanks!
Jon
