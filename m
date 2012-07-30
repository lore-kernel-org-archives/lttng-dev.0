From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: Module lttng_tracer not found.
Date: Mon, 30 Jul 2012 16:51:00 +0200
Message-ID: <50169F54.9060807__28388.8475307778$1343659852$gmane$org@mentor.com>
References: <CABy43G956NYAU4MG9p32+17jwJt8-6TZsdP9xysNs63CGw0hbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040408050204020104000206"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1SvrIg-0003r7-7I
	for lttng-dev@lists.lttng.org; Mon, 30 Jul 2012 10:50:26 -0400
In-Reply-To: <CABy43G956NYAU4MG9p32+17jwJt8-6TZsdP9xysNs63CGw0hbg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Rui Han <r.han@umiami.edu>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--------------040408050204020104000206
Content-Type: multipart/alternative;
	boundary="------------000502010800060700060506"

--------------000502010800060700060506
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.polymtl.ca id q6UEoRr5032718

Sorry, I forgot to CC the list.

On 07/29/2012 10:26 PM, Rui Han wrote:
> Hi,
>
> I used lttng last week and didn't touch it ever since. I am trying to=20
> use it again. I use lttng list -k, it give me error messages:
>
> FATAL: Module lttng_tracer not found.
> Error: Unable to load module lttng-tracer
> Error: Unable to remove module lttng-tracer
> Warning: No kernel tracer available
> Error: Unable to list kernel events
>
> I run kernel tracing as root. At first, I thought I have to start the=20
> daemon by lttng-sessiond command. It gave me the error: "Error:=20
> Already running daemon." At this time, I can create session, it gave=20
> "Session session created. Traces will be written in=20
> /root/lttng-traces/session-20120729-160806". However, it failed to=20
> generate a single term of tracing. While I tried lsmod, there are no=20
> lttng related module in the list. Which I remember there were several.=20
> The same thing happened to my two ubuntu systems. I restarted the=20
> system, it still doesn't work. Does any one know how to make lttng=20
> work again in this situation?
>
> Thank you very much.
>
> Best regards,
> Rui
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--=20
Paul Woegerer | SW Development Engineer
Mentor Embedded(tm) | Prinz Eugen Stra=DFe 72/2/4, Vienna, 1040 Austria
P 43.1.535991320
Nucleus=AE | Linux=AE | Android(tm) | Services | UI | Multi-OS

Android is a trademark of Google Inc. Use of this trademark is subject to=
 Google Permissions.
Linux is the registered trademark of Linus Torvalds in the U.S. and other=
 countries.


--------------000502010800060700060506
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Sorry, I forgot to CC the list.<br>
      <br>
      On 07/29/2012 10:26 PM, Rui Han wrote:<br>
    </div>
    <blockquote
cite="mid:CABy43G956NYAU4MG9p32+17jwJt8-6TZsdP9xysNs63CGw0hbg@mail.gmail.com"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html;
        charset=ISO-8859-1">
      <div>Hi,</div>
      <div><br>
      </div>
      <div>I used lttng last week and didn't touch it ever since. I am
        trying to use it again. I use lttng list -k, it give me error
        messages:</div>
      <div><br>
      </div>
      <div>FATAL: Module lttng_tracer not found.</div>
      <div>Error: Unable to load module lttng-tracer</div>
      <div>Error: Unable to remove module lttng-tracer</div>
      <div>Warning: No kernel tracer available</div>
      <div>Error: Unable to list kernel events</div>
      <div><br>
      </div>
      <div>I run kernel tracing as root. At first, I thought I have to
        start the daemon by lttng-sessiond command. It gave me the
        error: "Error: Already running daemon." At this time, I can
        create session, it gave "Session session created.&nbsp;Traces will be
        written in /root/lttng-traces/session-20120729-160806". However,
        it failed to generate a single term of tracing. While I tried
        lsmod, there are no lttng related module in the list. Which I
        remember there were several. The same thing happened to my two
        ubuntu systems. I restarted the system, it still doesn't
        work.&nbsp;Does any one know how to make lttng work again in this
        situation?</div>
      <div><br>
      </div>
      <div>Thank you very much.</div>
      <div><br>
      </div>
      <div>Best regards,</div>
      <div>Rui</div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
lttng-dev mailing list
<a class="moz-txt-link-abbreviated" href="mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a>
<a class="moz-txt-link-freetext" href="http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a>
</pre>
    </blockquote>
    <br>
    <br>
    <pre class="moz-signature" cols="72">-- 
Paul Woegerer | SW Development Engineer
Mentor Embedded(tm) | Prinz Eugen Stra&szlig;e 72/2/4, Vienna, 1040 Austria
P 43.1.535991320
Nucleus&reg; | Linux&reg; | Android(tm) | Services | UI | Multi-OS

Android is a trademark of Google Inc. Use of this trademark is subject to Google Permissions.
Linux is the registered trademark of Linus Torvalds in the U.S. and other countries.</pre>
  </body>
</html>

--------------000502010800060700060506--

--------------040408050204020104000206
Content-Type: message/rfc822; name="Attached Message"
Content-Disposition: attachment; filename="Attached Message"

Received: from SVR-ORW-FEM-04.mgc.mentorg.com (147.34.97.41) by
 SVR-IES-FEM-02.mgc.mentorg.com (137.202.0.106) with Microsoft SMTP Server
 (TLS) id 14.1.289.1; Mon, 30 Jul 2012 15:27:35 +0100
Received: from svr-orw-fem-01.mgc.mentorg.com (147.34.98.93) by
 SVR-ORW-FEM-04.mgc.mentorg.com (147.34.97.41) with Microsoft SMTP Server id
 14.1.289.1; Mon, 30 Jul 2012 07:27:33 -0700
Received: from relay1.mentorg.com ([192.94.38.131]) by
 svr-orw-fem-01.mgc.mentorg.com with Microsoft SMTPSVC(6.0.3790.4675);	 Mon,
 30 Jul 2012 07:27:19 -0700
Received: from exprod6mx189.postini.com ([64.18.1.41] helo=psmtp.com)	by
 relay1.mentorg.com with smtps (TLSv1:DHE-RSA-AES256-SHA:256)	id
 1SvqwJ-0004Wo-Eb from iurnah@gmail.com 	for Paul_Woegerer@mentor.com; Mon, 30
 Jul 2012 07:27:19 -0700
Received: from mail-gh0-f174.google.com ([209.85.160.174]) (using TLSv1) by
 exprod6mx189.postini.com ([64.18.5.10]) with SMTP;	Mon, 30 Jul 2012 07:27:19
 PDT
Received: by ghrr11 with SMTP id r11so5327601ghr.5        for
 <Paul_Woegerer@mentor.com>; Mon, 30 Jul 2012 07:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=m7TcczIIs3VOzL9dRzNCUYwL736DRD//Dq+NdxkKiks=;
        b=pWUOl6Z0XcEYQg9VDh3jgbmDUPWhBdR8XpwaT6U3oAXROKCTGz7vVc+NQfseXJYm9P
         qNPZPm77b/5p5I6bX6kmt3XGdCYgvQeunJJ+UNhqiwpt2NMmEFSCPmi5Dou3bZfDQOUQ
         K+lgChUOdFCPSPjnGfWv3I2uUZtbjVlRbAC2kJa7tfXR425erxwO1EHFiI+Ok7IRikHE
         8eeZNIhLArbQbbmDN2nNPSKxWZkv6la9QS7nWiSGYnvTezj1EyPtlCCpdWViHBsLCoak
         6F9kQxYYyHOkfCvlL5NCFeDJQxm5Y72/uj8/4m02ySDeIfwNOKdqj8jn9cGE+Ocw6JPz
         u/Iw==
Received: by 10.60.25.226 with SMTP id f2mr17712671oeg.13.1343658436721; Mon,
 30 Jul 2012 07:27:16 -0700 (PDT)
Received: by 10.182.141.5 with HTTP; Mon, 30 Jul 2012 07:27:16 -0700 (PDT)
In-Reply-To: <93eb99e0bef647c988ff776d8aa73878@UMEX005.cgcent.miami.edu>
References: <CABy43G956NYAU4MG9p32+17jwJt8-6TZsdP9xysNs63CGw0hbg@mail.gmail.com>
	<93eb99e0bef647c988ff776d8aa73878@UMEX005.cgcent.miami.edu>
Date: Mon, 30 Jul 2012 10:27:16 -0400
X-Google-Sender-Auth: 0PqULQwNFW_hF5OT2Lj4eG0Pip4
Message-ID: <CABy43G8xFD-CWCZfysWJOVOZT6tVM5LyRkQ1F39qbjBkv7Ebaw@mail.gmail.com>
Subject: Re: [lttng-dev] Module lttng_tracer not found.
From: Rui Han <r.han@umiami.edu>
To: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Content-Type: multipart/alternative; boundary="e89a8fb201e2d1fba904c60cdbd8"
X-pstn-neptune: 0/0/0.00/0
X-pstn-levels: (S:99.90000/99.90000 CV:99.9000 FC:95.5390 LC:95.5390 R:95.9108 P:95.9108 M:88.1613 C:98.6951 )
X-pstn-dkim: 1 skipped:not-enabled
X-pstn-settings: 4 (1.5000:0.0150) s cv GT3 gt2 gt1 r p m c 
X-pstn-addresses: from <r.han@umiami.edu> [db-null] 
Return-Path: iurnah@gmail.com
X-OriginalArrivalTime: 30 Jul 2012 14:27:19.0880 (UTC) FILETIME=[6D544480:01CD6E5F]
X-MS-Exchange-Organization-AuthSource: SVR-ORW-FEM-04.mgc.mentorg.com
X-MS-Exchange-Organization-AuthAs: Internal
X-MS-Exchange-Organization-AuthMechanism: 0b
X-MS-Exchange-Organization-AVStamp-Mailbox: SYMANTEC;452788608;0;info
MIME-Version: 1.0

--e89a8fb201e2d1fba904c60cdbd8
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Pual,
Thank you very much. This does remind me that I updated the kernel several
days ago. I reinstalled the packages and they work just fine.

Cheers,
Rui

On Mon, Jul 30, 2012 at 3:28 AM, Woegerer, Paul <Paul_Woegerer@mentor.com>w=
rote:

>  On 07/29/2012 10:26 PM, Rui Han wrote:
>
> Hi,
>
>  I used lttng last week and didn't touch it ever since. I am trying to
> use it again. I use lttng list -k, it give me error messages:
>
>  FATAL: Module lttng_tracer not found.
> Error: Unable to load module lttng-tracer
> Error: Unable to remove module lttng-tracer
> Warning: No kernel tracer available
> Error: Unable to list kernel events
>
>
> Sounds like the kernel got updated.
> Did you already try to recompile/reinstall the lttng-modules package ?
>
> --
> Paul
>
>
>  I run kernel tracing as root. At first, I thought I have to start the
> daemon by lttng-sessiond command. It gave me the error: "Error: Already
> running daemon." At this time, I can create session, it gave "Session
> session created. Traces will be written in
> /root/lttng-traces/session-20120729-160806". However, it failed to genera=
te
> a single term of tracing. While I tried lsmod, there are no lttng related
> module in the list. Which I remember there were several. The same thing
> happened to my two ubuntu systems. I restarted the system, it still doesn=
't
> work. Does any one know how to make lttng work again in this situation?
>
>  Thank you very much.
>
>  Best regards,
> Rui
>
>
> _______________________________________________
> lttng-dev mailing listlttng-dev@lists.lttng.orghttp://lists.lttng.org/cgi=
-bin/mailman/listinfo/lttng-dev
>
>
>
> --
> Paul Woegerer | SW Development Engineer
> Mentor Embedded(tm) | Prinz Eugen Stra=DFe 72/2/4, Vienna, 1040 Austria
> P 43.1.535991320
> Nucleus=AE | Linux=AE | Android(tm) | Services | UI | Multi-OS
>
> Android is a trademark of Google Inc. Use of this trademark is subject to=
 Google Permissions.
> Linux is the registered trademark of Linus Torvalds in the U.S. and other=
 countries.
>
>

--e89a8fb201e2d1fba904c60cdbd8
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">Hi Pual,<div>Thank you very much. This does remind me that I updated the=
 kernel several days ago. I reinstalled the packages and they work just fin=
e.<div><br></div><div>Cheers,</div><div>Rui<br><br><div class=3D"gmail_quot=
e">
On Mon, Jul 30, 2012 at 3:28 AM, Woegerer, Paul <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:Paul_Woegerer@mentor.com" target=3D"_blank">Paul_Woegerer@ment=
or.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">




<div text=3D"#000000" bgcolor=3D"#FFFFFF"><div class=3D"im">
<div>On 07/29/2012 10:26 PM, Rui Han wrote:<br>
</div>
<blockquote type=3D"cite">
<div>Hi,</div>
<div><br>
</div>
<div>I used lttng last week and didn't touch it ever since. I am trying to =
use it again. I use lttng list -k, it give me error messages:</div>
<div><br>
</div>
<div>FATAL: Module lttng_tracer not found.</div>
<div>Error: Unable to load module lttng-tracer</div>
<div>Error: Unable to remove module lttng-tracer</div>
<div>Warning: No kernel tracer available</div>
<div>Error: Unable to list kernel events</div>
</blockquote>
<br></div>
Sounds like the kernel got updated.<br>
Did you already try to recompile/reinstall the lttng-modules package ?<br>
<br>
--<br>
Paul<br>
<br>
<blockquote type=3D"cite"><div class=3D"im">
<div><br>
</div>
<div>I run kernel tracing as root. At first, I thought I have to start the =
daemon by lttng-sessiond command. It gave me the error: &quot;Error: Alread=
y running daemon.&quot; At this time, I can create session, it gave &quot;S=
ession session created.&nbsp;Traces will be written
 in /root/lttng-traces/session-20120729-160806&quot;. However, it failed to=
 generate a single term of tracing. While I tried lsmod, there are no lttng=
 related module in the list. Which I remember there were several. The same =
thing happened to my two ubuntu systems.
 I restarted the system, it still doesn't work.&nbsp;Does any one know how =
to make lttng work again in this situation?</div>
<div><br>
</div>
<div>Thank you very much.</div>
<div><br>
</div>
<div>Best regards,</div>
<div>Rui</div>
<br>
<fieldset></fieldset> <br>
</div><pre>_______________________________________________
lttng-dev mailing list
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
span class=3D"HOEnZb"><font color=3D"#888888">
</font></span></pre><span class=3D"HOEnZb"><font color=3D"#888888">
</font></span></blockquote><span class=3D"HOEnZb"><font color=3D"#888888">
<br>
<br>
<pre cols=3D"72">--=20
Paul Woegerer | SW Development Engineer
Mentor Embedded(tm) | Prinz Eugen Stra=DFe 72/2/4, Vienna, 1040 Austria
P 43.1.535991320
Nucleus=AE | Linux=AE | Android(tm) | Services | UI | Multi-OS

Android is a trademark of Google Inc. Use of this trademark is subject to G=
oogle Permissions.
Linux is the registered trademark of Linus Torvalds in the U.S. and other c=
ountries.</pre>
</font></span></div>

</blockquote></div><br></div></div>

--e89a8fb201e2d1fba904c60cdbd8--

--------------040408050204020104000206
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--------------040408050204020104000206--
