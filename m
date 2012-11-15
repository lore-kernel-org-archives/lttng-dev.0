From: =?ISO-8859-1?Q?Rapha=EBl_Beamonte?= <raphael.beamonte@polymtl.ca>
Subject: Re: [PATCH] runtests: Make path of time binary
	configurable
Date: Thu, 15 Nov 2012 00:59:48 -0500
Message-ID: <CAE_Gge3Nzp+EgBrvHuEJsNjEz-fdp=EMTBi+i4O6UzSXegGXmQ__21590.2367294349$1352959263$gmane$org@mail.gmail.com>
References: <1352953485-29736-1-git-send-email-simon.marchi@polymtl.ca>
	<20121115050017.GA19512@Krystal>
	<CAFXXi0kt1OWZ6wteNAwL=4k7Lmt7=YtciLxyyUJanC7ok3tB3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1377137971=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vb0-f48.google.com ([209.85.212.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <nashii@gmail.com>) id 1TYsUo-0008BN-Be
	for lttng-dev@lists.lttng.org; Thu, 15 Nov 2012 01:00:14 -0500
Received: by mail-vb0-f48.google.com with SMTP id e21so1563606vbm.35
	for <lttng-dev@lists.lttng.org>; Wed, 14 Nov 2012 22:00:08 -0800 (PST)
In-Reply-To: <CAFXXi0kt1OWZ6wteNAwL=4k7Lmt7=YtciLxyyUJanC7ok3tB3Q@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

--===============1377137971==
Content-Type: multipart/alternative; boundary=20cf307cfd640452b404ce825d39

--20cf307cfd640452b404ce825d39
Content-Type: text/plain; charset=ISO-8859-1

>
> If I understand correctly, it is not an environment variable until you
> export it (thus make it available to child processes). There is such a
> thing plain variable, there is just one big scope. I think there is
> not a single right way to do this, but I tend to agree with the SO
> answer below. By using capitalized names, you risk interfering with
> important environment variables. It would be a shame to do
> PATH="/tmp/something" by accident.
>
> The answer I am referring to:
>
> http://stackoverflow.com/questions/673055/correct-bash-and-shell-script-variable-capitalization
> .
>

I approve what Simon says.
There is no real convention, and it is common to use "_"-separated
variables names for non-exported ones, to be able to distinguish which one
was/will be exported. In fact, it is also "promoted" by this book :
http://goo.gl/IBFza (read full paragraph, there is a part on the next page)

On the other hand, it is commonly said that if you work on a bash script
that already has a convention, you have to be consistent to it.

--20cf307cfd640452b404ce825d39
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">If I understand c=
orrectly, it is not an environment variable until you<br>
export it (thus make it available to child processes). There is such a<br>
thing plain variable, there is just one big scope. I think there is<br>
not a single right way to do this, but I tend to agree with the SO<br>
answer below. By using capitalized names, you risk interfering with<br>
important environment variables. It would be a shame to do<br>
PATH=3D&quot;/tmp/something&quot; by accident.<br>
<br>
The answer I am referring to:<br>
<a href=3D"http://stackoverflow.com/questions/673055/correct-bash-and-shell=
-script-variable-capitalization" target=3D"_blank">http://stackoverflow.com=
/questions/673055/correct-bash-and-shell-script-variable-capitalization</a>=
.<br>

</blockquote><div><br>I approve what Simon says.<br>There is no real conven=
tion, and it is common to use &quot;_&quot;-separated variables names for n=
on-exported ones, to be able to distinguish which one was/will be exported.=
 In fact, it is also &quot;promoted&quot; by this book : <a href=3D"http://=
goo.gl/IBFza">http://goo.gl/IBFza</a> (read full paragraph, there is a part=
 on the next page)<br>

<br>On the other hand, it is commonly said that if you work on a bash scrip=
t that already has a convention, you have to be consistent to it.<br></div>=
</div>

--20cf307cfd640452b404ce825d39--


--===============1377137971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1377137971==--
