From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: Define __STDC_LIMIT_MACROS
 to fix C++ builds
Date: Mon, 10 Feb 2014 11:05:07 -0500
Message-ID: <CA+jJMxtYSv=piyXCvx=Azesz4ySg-amh=svBb-_oZkaFDwnSog__6821.08733240074$1392048380$gmane$org@mail.gmail.com>
References: <1391815941-30337-1-git-send-email-jeremie.galarneau@efficios.com>
	<2121067902.21017.1391874228506.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1WCtM9-0008SV-Mq
	for lttng-dev@lists.lttng.org; Mon, 10 Feb 2014 11:05:19 -0500
Received: by mail-qa0-f49.google.com with SMTP id w8so9677415qac.36
	for <lttng-dev@lists.lttng.org>; Mon, 10 Feb 2014 08:05:08 -0800 (PST)
In-Reply-To: <2121067902.21017.1391874228506.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Sat, Feb 8, 2014 at 10:43 AM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> ----- Original Message -----
>> From: "J=E9r=E9mie Galarneau" <jeremie.galarneau@efficios.com>
>> To: lttng-dev@lists.lttng.org
>> Sent: Friday, February 7, 2014 6:32:21 PM
>> Subject: [lttng-dev] [PATCH lttng-tools] Fix: Define __STDC_LIMIT_MACROS=
 to   fix C++ builds
>>
>> Necessary to include the fixed-width type limits on glibc versions
>> older than 2.18 when building with a C++ compiler.
>>
>> Signed-off-by: J=E9r=E9mie Galarneau <jeremie.galarneau@efficios.com>
>> ---
>>  include/lttng/lttng.h | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/include/lttng/lttng.h b/include/lttng/lttng.h
>> index 18dec2a..2d410fa 100644
>> --- a/include/lttng/lttng.h
>> +++ b/include/lttng/lttng.h
>> @@ -23,7 +23,13 @@
>>  #define LTTNG_H
>>
>>  #include <limits.h>
>> +/*
>> + * Necessary to include the fixed width type limits on glibc versions o=
lder
>> + * than 2.18 when building with a C++ compiler.
>> + */
>> +#define __STDC_LIMIT_MACROS
>>  #include <stdint.h>
>> +#undef __STDC_LIMIT_MACROS
>
> This has a side-effect: it undefines the __STDC_LIMIT_MACROS if it was
> defined prior to including this header. It should be:

Good point! Resubmitting as v2.

Regards,
J=E9r=E9mie

>
> #ifndef __STDC_LIMIT_MACROS
> #define __STDC_LIMIT_MACROS
> #include <stdint.h>
> #undef __STDC_LIMIT_MACROS
> #else /* #ifndef __STDC_LIMIT_MACROS */
> #include <stdint.h>
> #endif /* #else #ifndef __STDC_LIMIT_MACROS */
>
> Thanks,
>
> Mathieu
>
>>  #include <sys/types.h>
>>
>>  /* Error codes that can be returned by API calls */
>> --
>> 1.8.5.2
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
