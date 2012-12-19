From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: babletrace with python bindings
Date: Wed, 19 Dec 2012 13:39:32 -0500
Message-ID: <20121219183932.GA9587__28871.4459901259$1355942429$gmane$org@Krystal>
References: <20121218184045.288000@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1TlOYI-0006zm-8l
	for lttng-dev@lists.lttng.org; Wed, 19 Dec 2012 13:39:34 -0500
Content-Disposition: inline
In-Reply-To: <20121218184045.288000@gmx.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: ajonwa ajonwa <ajonwa@gmx.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* ajonwa ajonwa (ajonwa@gmx.com) wrote:
> Hello everyone,
> 
>  I get the following error message while attempting to compile babeltrace with python bindings:
> 
>  CC _babeltrace_la-babeltrace_wrap.lo
> babeltrace_wrap.c: In function '_wrap__bt_ctf_field_type':
> babeltrace_wrap.c:4621:56: warning: passing argument 1 of 'bt_ctf_field_type' from incompatible pointer type [enabled by default]
> ../../include/babeltrace/ctf/events.h:158:18: note: expected 'const struct declaration *' but argument is of type 'const struct definition *'
> babeltrace_wrap.c: In function '_wrap__bt_ctf_get_int_signedness':
> babeltrace_wrap.c:4643:51: warning: passing argument 1 of 'bt_ctf_get_int_signedness' from incompatible pointer type [enabled by default]
> ../../include/babeltrace/ctf/events.h:167:5: note: expected 'const struct declaration *' but argument is of type 'const struct definition *'
> babeltrace_wrap.c: In function '_wrap__bt_ctf_get_int_base':
> babeltrace_wrap.c:4665:45: warning: passing argument 1 of 'bt_ctf_get_int_base' from incompatible pointer type [enabled by default]
> ../../include/babeltrace/ctf/events.h:172:5: note: expected 'const struct declaration *' but argument is of type 'const struct definition *'
> babeltrace_wrap.c: In function '_wrap__bt_ctf_get_int_byte_order':
> babeltrace_wrap.c:4687:51: warning: passing argument 1 of 'bt_ctf_get_int_byte_order' from incompatible pointer type [enabled by default]
> ../../include/babeltrace/ctf/events.h:178:5: note: expected 'const struct declaration *' but argument is of type 'const struct definition *'
> babeltrace_wrap.c: In function '_wrap__bt_ctf_get_int_len':
> babeltrace_wrap.c:4709:39: warning: passing argument 1 of 'bt_ctf_get_int_len' from incompatible pointer type [enabled by default]
> ../../include/babeltrace/ctf/events.h:184:9: note: expected 'const struct declaration *' but argument is of type 'const struct definition *'
> babeltrace_wrap.c: In function '_wrap__bt_ctf_get_encoding':
> babeltrace_wrap.c:4731:66: warning: passing argument 1 of 'bt_ctf_get_encoding' from incompatible pointer type [enabled by default]
> ../../include/babeltrace/ctf/events.h:190:26: note: expected 'const struct declaration *' but argument is of type 'const struct definition *'
> babeltrace_wrap.c: In function '_wrap__bt_ctf_get_array_len':
> babeltrace_wrap.c:4753:46: warning: passing argument 1 of 'bt_ctf_get_array_len' from incompatible pointer type [enabled by default]
> ../../include/babeltrace/ctf/events.h:196:5: note: expected 'const struct declaration *' but argument is of type 'const struct definition *'
> babeltrace_wrap.c: In function 'init_babeltrace':
> babeltrace_wrap.c:6020:61: error: 'BT_SEEK_END' undeclared (first use in this function)
> babeltrace_wrap.c:6020:61: note: each undeclared identifier is reported only once for each function it appears in
> make[3]: *** [_babeltrace_la-babeltrace_wrap.lo] Error 1
> 
>  I got the source code by checking out bindings/python (git checkout bindings/python).
> 
>  I will be grateful if someone would tell how to fix the error.

This branch is currently in development, and might be out of sync with
the master branch of babeltrace at the moment. We don't have immediate
plans to work on it, but bontributions are welcome.

Thanks,

Mathieu

> 
> 
> 
>  Thanks,
> 
>  Geoffrey

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com
