From: Pierre-Luc St-Charles <pierre-luc.st-charles@polymtl.ca>
Subject: Re: LTTng system call tracing on ARM
Date: Wed, 10 Apr 2013 08:39:12 -0400
Message-ID: <CA+umk=rWpr=SKTgDwSmyT1W+5Fs45iRjkFJD_-eAHDiVMiSB-w__13548.180627595$1365597586$gmane$org@mail.gmail.com>
References: <20130410084053.GB25958@hal>
	<CA+umk=pX-4t74XQqsP+vLsDGF1atWzUi75gmSyoVGsDkqQcB7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2059734719=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <b0mb00z.it@gmail.com>) id 1UPuJ4-0003tE-1E
	for lttng-dev@lists.lttng.org; Wed, 10 Apr 2013 08:39:18 -0400
Received: by mail-pb0-f47.google.com with SMTP id rq13so244440pbb.34
	for <lttng-dev@lists.lttng.org>; Wed, 10 Apr 2013 05:39:12 -0700 (PDT)
In-Reply-To: <CA+umk=pX-4t74XQqsP+vLsDGF1atWzUi75gmSyoVGsDkqQcB7g@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jan Glauber <jan.glauber@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============2059734719==
Content-Type: multipart/alternative; boundary=e89a8f50379203aa1b04da00f5db

--e89a8f50379203aa1b04da00f5db
Content-Type: text/plain; charset=ISO-8859-1

Hey Jan,

I cannot speak on behalf of everyone here, but during our attempt to port
LTTng to Android, we also noticed that the kernels we were using (3.0.x)
were nowhere near the requirements for syscall tracepoints support. I
believe such support was added on x86/64 way earlier (early 3.x) than on
ARM, which is why it was included in LTTng's modules a while ago. Simply
put, the ARM kernel is late.

There are a few actuals ways to 'enable' syscall tracepoints support on
early ARM kernels, but they all including a bit of kernel hacking/patching.
I could send you some links if you're interested in that.

-PL
On Apr 10, 2013 8:37 AM, "PLSTC" <b0mb00z.it@gmail.com> wrote:

> Hey Jan,
>
> I cannot speak on behalf of everyone here, but during our attempt to port
> LTTng to Android, we also noticed that the kernels we were using (3.0.x)
> were nowhere near the requirements for syscall tracepoints support. I
> believe such support was added on x86/64 way earlier (early 3.x) than on
> ARM, which is why it was included in LTTng's modules a while ago. Simply
> put, the ARM kernel is late.
>
> There are a few actuals ways to 'enable' syscall tracepoints support on
> early ARM kernels, but they all including a bit of kernel hacking/patching.
> I could send you some links if you're interested in that.
>
> -PL
> On Apr 10, 2013 4:40 AM, "Jan Glauber" <jan.glauber@gmail.com> wrote:
>
>> Hi,
>>
>> I want to use LTTng for system call tracing on ARM. Now lttng-modules
>> seems
>> to support system call tracing on ARM already since
>> "8f4f80e LTTng Modules ARM syscall instrumentation".
>>
>> But I wonder how that worked since lttng-syscalls.c is only build under
>> CONFIG_HAVE_SYSCALL_TRACEPOINTS and that was added to ARM only with
>> kernel 3.6
>> (much after than the lttng-modules commit).
>>
>> Am I missing something? Is system call tracing working on ARM with the
>> upstream
>> LTTng version?
>>
>> thanks,
>> Jan
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>

--e89a8f50379203aa1b04da00f5db
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Hey Jan,</p>
<p dir=3D"ltr">I cannot speak on behalf of everyone here, but during our at=
tempt to port LTTng to Android, we also noticed that the kernels we were us=
ing (3.0.x) were nowhere near the requirements for syscall tracepoints supp=
ort. I believe such support was added on x86/64 way earlier (early 3.x) tha=
n on ARM, which is why it was included in LTTng&#39;s modules a while ago. =
Simply put, the ARM kernel is late.</p>

<p dir=3D"ltr">There are a few actuals ways to &#39;enable&#39; syscall tra=
cepoints support on early ARM kernels, but they all including a bit of kern=
el hacking/patching. I could send you some links if you&#39;re interested i=
n that.</p>

<p dir=3D"ltr">-PL</p>
<div class=3D"gmail_quote">On Apr 10, 2013 8:37 AM, &quot;PLSTC&quot; &lt;<=
a href=3D"mailto:b0mb00z.it@gmail.com">b0mb00z.it@gmail.com</a>&gt; wrote:<=
br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<p dir=3D"ltr">Hey Jan,</p>
<p dir=3D"ltr">I cannot speak on behalf of everyone here, but during our at=
tempt to port LTTng to Android, we also noticed that the kernels we were us=
ing (3.0.x) were nowhere near the requirements for syscall tracepoints supp=
ort. I believe such support was added on x86/64 way earlier (early 3.x) tha=
n on ARM, which is why it was included in LTTng&#39;s modules a while ago. =
Simply put, the ARM kernel is late.</p>


<p dir=3D"ltr">There are a few actuals ways to &#39;enable&#39; syscall tra=
cepoints support on early ARM kernels, but they all including a bit of kern=
el hacking/patching. I could send you some links if you&#39;re interested i=
n that.</p>


<p dir=3D"ltr">-PL</p>
<div class=3D"gmail_quote">On Apr 10, 2013 4:40 AM, &quot;Jan Glauber&quot;=
 &lt;<a href=3D"mailto:jan.glauber@gmail.com" target=3D"_blank">jan.glauber=
@gmail.com</a>&gt; wrote:<br type=3D"attribution"><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">

Hi,<br>
<br>
I want to use LTTng for system call tracing on ARM. Now lttng-modules seems=
<br>
to support system call tracing on ARM already since<br>
&quot;8f4f80e LTTng Modules ARM syscall instrumentation&quot;.<br>
<br>
But I wonder how that worked since lttng-syscalls.c is only build under<br>
CONFIG_HAVE_SYSCALL_TRACEPOINTS and that was added to ARM only with kernel =
3.6<br>
(much after than the lttng-modules commit).<br>
<br>
Am I missing something? Is system call tracing working on ARM with the upst=
ream<br>
LTTng version?<br>
<br>
thanks,<br>
Jan<br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
</blockquote></div>
</blockquote></div>

--e89a8f50379203aa1b04da00f5db--


--===============2059734719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2059734719==--
