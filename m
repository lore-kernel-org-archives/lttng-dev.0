From: =?ISO-8859-1?Q?J=E9r=E9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: Building Babeltrace
Date: Wed, 6 Nov 2013 15:17:35 -0500
Message-ID: <CA+jJMxujbk_c2YxHM1NXLssB4irRz2maAWHYU3eDApAJTtRCig__19881.7641394728$1383769131$gmane$org@mail.gmail.com>
References: <F98AC8DFC04DC741915F3DFB00515DBEE8972716@Thetis.ISE-DOM.local>
	<F98AC8DFC04DC741915F3DFB00515DBEE897275C@Thetis.ISE-DOM.local>
	<CA+jJMxt1ANnowdofJweazFts5f+Rarnx0gwwmDUh-UyMvRYjVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jeremie.galarneau@gmail.com>) id 1Ve9Xp-0005s3-3B
	for lttng-dev@lists.lttng.org; Wed, 06 Nov 2013 15:17:46 -0500
Received: by mail-qa0-f45.google.com with SMTP id hu16so2484360qab.11
	for <lttng-dev@lists.lttng.org>; Wed, 06 Nov 2013 12:17:35 -0800 (PST)
In-Reply-To: <CA+jJMxt1ANnowdofJweazFts5f+Rarnx0gwwmDUh-UyMvRYjVg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Paul Thomas <paul.thomas@ise.bc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Just as a heads-up, you may want to use the latest tarball release
since it appears that I have used glib functions that were not
available in glib 2.22. I'm currently working on a patch to address
this problem.

Cheers,
J=E9r=E9mie

On Wed, Nov 6, 2013 at 2:57 PM, J=E9r=E9mie Galarneau
<jeremie.galarneau@efficios.com> wrote:
> On Wed, Nov 6, 2013 at 2:00 PM, Paul Thomas <paul.thomas@ise.bc.ca> wrote:
>>
>> Hello:
>>
>> I get the following when building babeltrace from git:
>>
>> make[4]: Entering directory `/rt_linux/babeltrace/formats/ctf/writer'
>>   CC     writer.lo
>> writer.c: In function 'bt_ctf_writer_create':
>> writer.c:118: error: 'O_DIRECTORY' undeclared (first use in this functio=
n)
>> writer.c:118: error: (Each undeclared identifier is reported only once
>> writer.c:118: error: for each function it appears in.)
>> writer.c: In function 'validate_identifier':
>> writer.c:564: warning: implicit declaration of function 'g_hash_table_co=
ntains'
>> writer.c: In function 'writer_init':
>> writer.c:741: warning: implicit declaration of function 'g_hash_table_ad=
d'
>> make[4]: *** [writer.lo] Error 1
>> make[4]: Leaving directory `/rt_linux/babeltrace/formats/ctf/writer'
>> make[3]: *** [all-recursive] Error 1
>> make[3]: Leaving directory `/rt_linux/babeltrace/formats/ctf'
>> make[2]: *** [all-recursive] Error 1
>> make[2]: Leaving directory `/rt_linux/babeltrace/formats'
>> make[1]: *** [all-recursive] Error 1
>> make[1]: Leaving directory `/rt_linux/babeltrace'
>> make: *** [all] Error 2
>>
>> I am running Debian:  gcc/g++ 4.4.5-8
>> Linux debian-rt 2.6.31.51 #1 SMP PREEMPT i686 GNU/Linux
>>
>> Should I be compiling from a tarball instead?
>>
>
> Thanks for reporting. This commit should fix the error.
>
> commit 1b8180b91647e07b243c472e1f0c6ae198f82585
> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Date:   Wed Nov 6 14:52:59 2013 -0500
>
>     ctf writer BSD compatibily: remove O_DIRECTORY
>
>     Not strictly needed, especially since we are creating the directory
>     ourself.
>
>     Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>
>
> Let me know if you still can't build babeltrace with the latest master.
>
> J=E9r=E9mie
>
>>
>> Thanks,
>>
>> Paul
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
>
>
> --
> J=E9r=E9mie Galarneau
> EfficiOS Inc.
> http://www.efficios.com



-- =

J=E9r=E9mie Galarneau
EfficiOS Inc.
http://www.efficios.com
