From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: Python CTF writer example
Date: Tue, 17 Sep 2019 15:17:56 -0400
Message-ID: <20190917191756.GD143064__42811.449889426$1568747902$gmane$org@joraj-alpa>
References: <CAC6yHM7iNtK7nt30mq2xeX5Z_K9nhEND6XP6jHS-s7dAJGkgZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 46XtDW2kWvzqMZ
 for <lttng-dev@lists.lttng.org>; Tue, 17 Sep 2019 15:18:03 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 9E9D51D6806
 for <lttng-dev@lists.lttng.org>; Tue, 17 Sep 2019 15:17:57 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAC6yHM7iNtK7nt30mq2xeX5Z_K9nhEND6XP6jHS-s7dAJGkgZA@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Francis Giraldeau <francis.giraldeau@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

On Fri, Sep 13, 2019 at 07:03:59PM -0400, Francis Giraldeau wrote:
> Hello!
> 
> It looks like there are some issues with the Python CTF writer example with
> babeltrace stable-1.5.

I will infer that you are looking at this doc:

  https://diamon.org/babeltrace/docs/python/examples/#ctf-writer-api-examples

This doc is currently outdated(invalid). We are in the process of
revamping it/removing it.

If you need an example for bt 1.5 use:

  https://github.com/efficios/babeltrace/blob/stable-1.5/bindings/python/babeltrace/examples/ctf_writer.py

This example works as expected.

> 
> * Import error, should replace "import babeltrace.writer as btw" by "from
> babeltrace import CTFWriter as btw"
> * The FloatingPointDeclaration does not exists and should be replaced
> by FloatFieldDeclaration
> * babeltrace.common.CTFStringEncoding.UTF8 is
> instead babeltrace.CTFStringEncoding.UTF8
> * The variant still had issue that I cannot fix (ValueError("Invalid tag
> provided.") babeltrace.py:2221)

If you still wish to follow the documentation, please make sure to read the
green notice here:
  https://diamon.org/babeltrace/docs/python/examples/#examples

> 
> Events with simple fields are working okay with these changes. I thought
> that the clock would be updated automatically when appending the event, but
> that would be nice also to add it to the example.
> 
> I tried babeltrace 2.0.0-pre6, but the writer API seems to have
> disappeared. I was looking at how to create a ctf.fs.sink, but I was not
> successful. Is writing CTF traces with the Python bindings still possible?

The ctf-writer capability are not part of the bindings anymore.
 https://review.lttng.org/c/babeltrace/+/1392

What can be done is writing a source plugin using the bindings and use a ctf
sink on the cli to generate a ctf trace.

A quick source plugin: http://paste.ubuntu.com/p/8CBqTt8cSj/

Note that babeltrace 1.5 and babeltrace 2 can coexist on the same system.
Allowing you to still use the bindings from bt1.5 to generate traces.

I recommend that you stick with the babeltrace 1.5 bindings (import babeltrace).

Cheers

-- 
Jonathan Rajotte-Julien
EfficiOS
