From: Xiaona Han <xiaonahappy13@gmail.com>
Subject: Re: GSoC 2013 idea: support a new language binding for
	lttng
Date: Thu, 25 Apr 2013 16:01:09 +0800
Message-ID: <CAMMh03O4t8U1aaEk+VAZo4+GrV8cMEOEFr=Ns3V1ZbgOos0e9A__9575.58396407894$1366876903$gmane$org@mail.gmail.com>
References: <CAMMh03NCLpR453cAco3aWrmw63BLGJPa+CVane0xTk6ADhr8zw@mail.gmail.com>
	<CAGDH53mzO04Cktp1ggJ8sW_zDfY7j5St20-P4xswKa2a9D4CYg@mail.gmail.com>
	<CA+jJMxtJPH0JNUMH0bZHdO6b0yeN_2wvqoyrwAaRamKcNU8VkA@mail.gmail.com>
	<CAMMh03PSP00DMVqy37DogVZGZCi70just9QMH2XvafjdG=vB8Q@mail.gmail.com>
	<CAEzWAe+7zw9=nOLNCsXFcjtz18bGo=rOeV_YTsGJrYZHRJy1QA@mail.gmail.com>
	<CAMMh03MVH=Te=BbQoofqdmZwjEJD-RJE14Ga1PpcSfTn-YEp3A@mail.gmail.com>
	<517680EA.50203@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1971361012=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f44.google.com ([209.85.215.44])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <xiaonahappy13@gmail.com>) id 1UVH7D-0005fz-WA
	for lttng-dev@lists.lttng.org; Thu, 25 Apr 2013 04:01:16 -0400
Received: by mail-la0-f44.google.com with SMTP id ed20so2360149lab.31
	for <lttng-dev@lists.lttng.org>; Thu, 25 Apr 2013 01:01:09 -0700 (PDT)
In-Reply-To: <517680EA.50203@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yannick Brosseau <yannick.brosseau@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1971361012==
Content-Type: multipart/alternative; boundary=089e0149401c43c4e104db2ad2fd

--089e0149401c43c4e104db2ad2fd
Content-Type: text/plain; charset=ISO-8859-1

Hi Yannick,

2013/4/23 Yannick Brosseau <yannick.brosseau@gmail.com>

> On 2013-04-15 10:25, Xiaona Han wrote:
> > Hi Yannick
> >    Thanks for your encouragement. I take a quick look at the source
> > code of lttng and find that lttng-tools has python bindings code. It
> > means that support Lua bindings mainly need finish the code,
> > documentations and tests for the lttng-tools. What about babeltrace?
> > Do we need support  Lua bindings for babeltrace APIs in this project?
> Hi Xiaona,
>
> I taken a look at your proposal for GSoC. As you say here, looking at
> the babeltrace API could also be interesting and could fit very well in
> the time frame. Last year, we had an intern doing the binding for Python
> and i fitted well in 4 months.
> I would also suggest, that you add some exploration for the addition of
> UST tracepoint to the lua language. This one is probably more
> complicated, so it might be added to the description as an additionnal
> item if time permit.
>
Done. The main change of the proposal is the timeline part. Thanks.

Xiaona Han
Best regards.


>
> Yannick
>

--089e0149401c43c4e104db2ad2fd
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Yannick,<div>=A0 =A0=A0<div class=3D"gmail_extra"><div =
class=3D"gmail_quote">2013/4/23 Yannick Brosseau <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:yannick.brosseau@gmail.com" target=3D"_blank">yannick.brossea=
u@gmail.com</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div class=3D"im">On 2013-04-15 10:25, Xiaona Han wrote:<b=
r>

&gt; Hi Yannick<br>
&gt; =A0 =A0Thanks for your encouragement. I take a quick look at the sourc=
e<br>
&gt; code of lttng and find that lttng-tools has python bindings code. It<b=
r>
&gt; means that support Lua bindings mainly need finish the code,<br>
&gt; documentations and tests for the lttng-tools. What about babeltrace?<b=
r>
&gt; Do we need support =A0Lua bindings for babeltrace APIs in this project=
?<br>
</div>Hi Xiaona,<br>
<br>
I taken a look at your proposal for GSoC. As you say here, looking at<br>
the babeltrace API could also be interesting and could fit very well in<br>
the time frame. Last year, we had an intern doing the binding for Python<br=
>
and i fitted well in 4 months.<br>
I would also suggest, that you add some exploration for the addition of<br>
UST tracepoint to the lua language. This one is probably more<br>
complicated, so it might be added to the description as an additionnal<br>
item if time permit.<br></blockquote>Done. The main change of the proposal =
is the timeline part. Thanks.</div><div class=3D"gmail_quote"><br></div><di=
v class=3D"gmail_quote">Xiaona Han</div><div class=3D"gmail_quote">Best reg=
ards.<br>
<div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left=
-style:solid;padding-left:1ex">
<span class=3D""><font color=3D"#888888"><br>
Yannick<br>
</font></span></blockquote></div><br></div></div></div>

--089e0149401c43c4e104db2ad2fd--


--===============1971361012==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1971361012==--
