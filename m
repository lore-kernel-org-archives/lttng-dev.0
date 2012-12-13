From: Jan Blunck <jblunck@infradead.org>
Subject: Re: How to document existing tracepoints (e.g. doxygen)
Date: Thu, 13 Dec 2012 13:08:13 +0100
Message-ID: <CALe+Z01Fj56CmS8CBEnqec5j+f=M3w6MbFN3zJMUadFBrQbVHw__10992.0417228297$1355400532$gmane$org@mail.gmail.com>
References: <CALe+Z03oNt7L8=5CJUY1ss+-yWBvoTevv=En_4E58Y8d=m_x9A@mail.gmail.com>
	<20121213114614.GB9780@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jblunck@gmail.com>) id 1Tj7aM-0003u9-KU
	for lttng-dev@lists.lttng.org; Thu, 13 Dec 2012 07:08:18 -0500
Received: by mail-oa0-f48.google.com with SMTP id h2so2044623oag.35
	for <lttng-dev@lists.lttng.org>; Thu, 13 Dec 2012 04:08:13 -0800 (PST)
In-Reply-To: <20121213114614.GB9780@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On Thu, Dec 13, 2012 at 12:46 PM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> * Jan Blunck (jblunck@infradead.org) wrote:
>>
>> I tried to do that with doxygen but it did not work out of the box.
>> The target audience are sysadmins that should not or could not be
>> forced to read the source.
>
> I'd think that doxygen would be appropriate. What issues did you run
> into when trying going down that route ?
>

Doxygen was not able to parse through the macros correctly. Therefore
the output was not really what I would have expected. Anyway, I'll
continue to investigate how to tell doxygen to correctly parse this.

Thanks,
Jan


> Thanks,
>
> Mathieu
>
>>
>> Regards,
>> Jan
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> --
> Mathieu Desnoyers
> Operating System Efficiency R&D Consultant
> EfficiOS Inc.
> http://www.efficios.com
