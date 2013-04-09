From: Simarpreet Singh <simarpreet007@gmail.com>
Subject: Re: Bugfix: Bug #488
Date: Tue, 9 Apr 2013 15:46:23 -0400
Message-ID: <CA+mmcvXfavEx+2ZFD-cfOFNxs5Fss30j0cNdx8jfenhqJhAKkQ__36139.3446605236$1365536813$gmane$org@mail.gmail.com>
References: <CA+mmcvU4d5ugJmxs4DyPbiis-JS3rMAZ7x8qZswoEDxDKiCssQ@mail.gmail.com>
	<51643CE4.4050902@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1118202855=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <simarpreet007@gmail.com>) id 1UPeUv-000421-AK
	for lttng-dev@lists.lttng.org; Tue, 09 Apr 2013 15:46:29 -0400
Received: by mail-wi0-f177.google.com with SMTP id hm14so4061730wib.16
	for <lttng-dev@lists.lttng.org>; Tue, 09 Apr 2013 12:46:23 -0700 (PDT)
In-Reply-To: <51643CE4.4050902@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>, christian.babeux@efficios.com, =?ISO-8859-1?Q?Rapha=EBl_Beamonte?= <raphael.beamonte@polymtl.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1118202855==
Content-Type: multipart/alternative; boundary=047d7bfd0bd6e60b9004d9f2ce9f

--047d7bfd0bd6e60b9004d9f2ce9f
Content-Type: text/plain; charset=ISO-8859-1

Hey guys,

Thanks for the help, I just submitted Fix #453 for a review, hopefully I
did it correct. *fingers crossed*

I'll be submitting fixes for #488 in a few hours.

Thanks again,
Simar


On Tue, Apr 9, 2013 at 12:08 PM, David Goulet <dgoulet@efficios.com> wrote:

> Hi Simarpreet,
>
> Can you please rebase your branch on the HEAD of the master branch of
> lttng-tools before sending a pull request.
>
> Also, when you fix a bug in the tracker, use "Fix:" with a meaningful
> message, add "Fixes #xxx" at the end and finally your signed-off message
> like so:
>
> ---
>
> Fix: [...]
>
> [more info if necessary]
>
> Fixes #xxx
>
> Signed-off-by: YOUR_NAME <YOUR_EMAIL>
>
> ---
>
> Apart from those aesthetics fix, thanks a lot for the contribution. I'll
> wait for your fixes to pull back the commits.
>
> Cheers!
> David
>
> Simarpreet Singh:
> > Hello again,
> >
> > Sorry for the emails guys, I fixed a bunch of other typos in the
> > codebase, I think these shall go under Bug #488.
> >
> > Bug URL: http://bugs.lttng.org/issues/488
> >
> > Fix:
> https://github.com/simar7/lttng-tools/commit/6a6df32f6fadcb85a275b8ea93306af2d498c263
> >
> > I've pushed my changes on my github account, I'll try to figure out the
> > correct way to file them in the meantime.
> >
> >
> > Thanks,
> > Simar
> >
> >
> > This body part will be downloaded on demand.
>

--047d7bfd0bd6e60b9004d9f2ce9f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hey guys,<div><br></div><div>Thanks for the help, I just s=
ubmitted Fix #453 for a review, hopefully I did it correct. *fingers crosse=
d*</div><div><br></div><div>I&#39;ll be submitting fixes for #488 in a few =
hours.</div>
<div><br></div><div>Thanks again,</div><div>Simar<br><div class=3D"gmail_ex=
tra"><br><br><div class=3D"gmail_quote">On Tue, Apr 9, 2013 at 12:08 PM, Da=
vid Goulet <span dir=3D"ltr">&lt;<a href=3D"mailto:dgoulet@efficios.com" ta=
rget=3D"_blank">dgoulet@efficios.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi Simarpreet,<br>
<br>
Can you please rebase your branch on the HEAD of the master branch of<br>
lttng-tools before sending a pull request.<br>
<br>
Also, when you fix a bug in the tracker, use &quot;Fix:&quot; with a meanin=
gful<br>
message, add &quot;Fixes #xxx&quot; at the end and finally your signed-off =
message<br>
like so:<br>
<br>
---<br>
<br>
Fix: [...]<br>
<br>
[more info if necessary]<br>
<br>
Fixes #xxx<br>
<br>
Signed-off-by: YOUR_NAME &lt;YOUR_EMAIL&gt;<br>
<br>
---<br>
<br>
Apart from those aesthetics fix, thanks a lot for the contribution. I&#39;l=
l<br>
wait for your fixes to pull back the commits.<br>
<br>
Cheers!<br>
David<br>
<br>
Simarpreet Singh:<br>
<div><div>&gt; Hello again,<br>
&gt;<br>
&gt; Sorry for the emails guys, I fixed a bunch of other typos in the<br>
&gt; codebase, I think these shall go under Bug #488.<br>
&gt;<br>
&gt; Bug URL: <a href=3D"http://bugs.lttng.org/issues/488" target=3D"_blank=
">http://bugs.lttng.org/issues/488</a><br>
&gt;<br>
&gt; Fix: <a href=3D"https://github.com/simar7/lttng-tools/commit/6a6df32f6=
fadcb85a275b8ea93306af2d498c263" target=3D"_blank">https://github.com/simar=
7/lttng-tools/commit/6a6df32f6fadcb85a275b8ea93306af2d498c263</a><br>
&gt;<br>
&gt; I&#39;ve pushed my changes on my github account, I&#39;ll try to figur=
e out the<br>
&gt; correct way to file them in the meantime.<br>
&gt;<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Simar<br>
&gt;<br>
&gt;<br>
</div></div>&gt; This body part will be downloaded on demand.<br>
</blockquote></div><br></div></div></div>

--047d7bfd0bd6e60b9004d9f2ce9f--


--===============1118202855==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1118202855==--
