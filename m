From: Francis Deslauriers <francis.deslauriers@mail.utoronto.ca>
Subject: Re: Can lttng support kernel function tracer
Date: Mon, 16 Feb 2015 11:53:00 -0500
Message-ID: <CADcCL0jj+wMX3ZX2dRBpjg5goGAz8_o7OWk=fqpJ1w8n3GTrDg__38619.9148641483$1424105687$gmane$org@mail.gmail.com>
References: <5a55c10f-2991-4d2c-ae9f-71bf32a96867@aliyun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-bn1on0095.outbound.protection.outlook.com ([157.56.110.95]
 helo=na01-bn1-obe.outbound.protection.outlook.com)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <francis.deslauriers@mail.utoronto.ca>)
 id 1YNOvP-0007h0-G3
 for lttng-dev@lists.lttng.org; Mon, 16 Feb 2015 11:53:38 -0500
Received: by mail-qa0-f50.google.com with SMTP id f12so22864058qad.9
 for <lttng-dev@lists.lttng.org>; Mon, 16 Feb 2015 08:53:21 -0800 (PST)
In-Reply-To: <5a55c10f-2991-4d2c-ae9f-71bf32a96867@aliyun.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Zhenyu,

If I understandd your question correctly, I can think of two ways to
trace an arbitrary kernel function. First, you can hook the tracer on
a dynamic probe[1] using something like this:
"lttng enable-event customEventName -k --probe kernelFunctionName".
You can also hook the tracer on both entry and exit of a function
using "--function" instead of "--probe".
To list your kernel symbols use "cat /proc/kallsyms"
Second, you can create custom kernel tracepoints and compile them in
you kernel. Have a look at the online documentation [2].

Don't hesitate to explain further if this doesn't answer your question.

Cheers!
Francis

[1] http://git.lttng.org/?p=lttng-tools.git;a=blob;f=doc/quickstart.txt;h=018c27b2b939ef7cd075255fd01bcfd8b2b21b1e;hb=HEAD#l93
[2] http://lttng.org/docs/#doc-instrumenting-linux-kernel-itself

On Thu, Feb 12, 2015 at 7:49 PM, zhenyu.ren <zhenyu.ren@aliyun.com> wrote:
> Hi,
>
>    It's well known that lttng can make use of kernel tracepoints to do block tracing ,system call tracing etc.Is it possible that  lttng can produce anything like kernel function tracer does?
>
> Thanks
> zhenyu.ren
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
