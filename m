From: Hongbo Zhang <hongbo.zhang@linaro.org>
Subject: Re: Does LTTng UST support ARM?
Date: Fri, 30 May 2014 16:53:54 +0800
Message-ID: <CAOhR-w3+L+MKzr1vYoC4JhN7kD1RS6xZVGkrHNphe2TdrjPS=Q__24440.7873055481$1401440113$gmane$org@mail.gmail.com>
References: <CAOhR-w31w=er_PfYtGk-QaC+S+iHPgxNH_11iJmKgO6_Bb=Zqw@mail.gmail.com>
 <CAEiAFz23qbrc7GHwHFVWk3Xi3YAzLZtNKaFTb0tbdhX-fTtjMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1920608538=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f178.google.com ([209.85.220.178])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <hongbo.zhang@linaro.org>) id 1WqIZc-0008Jk-IC
 for lttng-dev@lists.lttng.org; Fri, 30 May 2014 04:54:05 -0400
Received: by mail-vc0-f178.google.com with SMTP id ij19so1742161vcb.37
 for <lttng-dev@lists.lttng.org>; Fri, 30 May 2014 01:53:55 -0700 (PDT)
In-Reply-To: <CAEiAFz23qbrc7GHwHFVWk3Xi3YAzLZtNKaFTb0tbdhX-fTtjMA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jan Glauber <jan.glauber@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1920608538==
Content-Type: multipart/alternative; boundary=001a11335a8e766ce704fa9a2f5e

--001a11335a8e766ce704fa9a2f5e
Content-Type: text/plain; charset=UTF-8

Thank you Jan.
Encouraged by the truth that LTTng UST does work on ARM, I paid more
efforts and run it on my ARM board at last.

I am using a Ubuntu on my board, and I installed lttng-ust and
userspace-rcu from source codes, but installed lttng-tools by apt-get
command(the babeltrace was also included I think), the reason I failed to
trace the lttng-tools from apt-get doesn't work and even doesn't give any
suggestive output.
Then I re-installed lttng-tools and babeltrace from source codes again,
then everything works :)



On 29 May 2014 18:19, Jan Glauber <jan.glauber@gmail.com> wrote:

> Hi Hongbo,
> I'm using LTTng UST on ARM, so the statement that it does not support the
> ARM platform is certainly wrong.
>
> I don't know why you don't get trace results, can you provide some more
> details about your setup (LTTng versions, commands you are using, console
> output,...)
>
> Regards, Jan
>
>
> 2014-05-29 10:10 GMT+02:00 Hongbo Zhang <hongbo.zhang@linaro.org>:
>
>> Hi all,
>> I got info that LTTng UST didn't support ARM platform, does anybody know
>> if there is any update about this? LTTng UST still doesn't support ARM
>> nowadays?
>> I can compile and install userspace-rcu and lttng-ust, but cannot get
>> trace result.
>> Thanks.
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>
>>
>

--001a11335a8e766ce704fa9a2f5e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you Jan.<div>Encouraged by the truth that LTTng UST =
does work on ARM, I paid more efforts and run it on my ARM board at last.</=
div><div><br></div><div>I am using a Ubuntu on my board, and I installed lt=
tng-ust and userspace-rcu from source codes, but installed lttng-tools by a=
pt-get command(the babeltrace was also included I think), the reason I fail=
ed to trace the lttng-tools from apt-get doesn&#39;t work and even doesn&#3=
9;t give any suggestive output.</div>
<div>Then I re-installed lttng-tools and babeltrace from source codes again=
, then everything works :)</div><div><br></div></div><div class=3D"gmail_ex=
tra"><br><br><div class=3D"gmail_quote">On 29 May 2014 18:19, Jan Glauber <=
span dir=3D"ltr">&lt;<a href=3D"mailto:jan.glauber@gmail.com" target=3D"_bl=
ank">jan.glauber@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div><div><div><div>Hi Hong=
bo,<br></div>I&#39;m using LTTng UST on ARM, so the statement that it does =
not support the ARM platform is certainly wrong.<br>
</div><br></div>I don&#39;t know why you don&#39;t get trace results, can y=
ou provide some more details about your setup (LTTng versions, commands you=
 are using, console output,...)<br>
<br></div>Regards, Jan<br></div><div class=3D"gmail_extra"><br><br><div cla=
ss=3D"gmail_quote">2014-05-29 10:10 GMT+02:00 Hongbo Zhang <span dir=3D"ltr=
">&lt;<a href=3D"mailto:hongbo.zhang@linaro.org" target=3D"_blank">hongbo.z=
hang@linaro.org</a>&gt;</span>:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div><div class=3D"h5"><div dir=3D"ltr">Hi a=
ll,<div>I got info that LTTng UST didn&#39;t support ARM platform, does any=
body know if there is any update about this? LTTng UST still doesn&#39;t su=
pport ARM nowadays?</div>

<div>I can compile and install userspace-rcu and lttng-ust, but cannot get =
trace result.</div>
<div>Thanks.</div></div>
<br></div></div>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
<br></blockquote></div><br></div>
</blockquote></div><br></div>

--001a11335a8e766ce704fa9a2f5e--


--===============1920608538==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1920608538==--
