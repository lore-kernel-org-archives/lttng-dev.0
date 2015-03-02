From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Subject: Re: babeltrace lttng-live format option
Date: Mon, 02 Mar 2015 15:10:08 -0500
Message-ID: <54F4C3A0.2030207__42801.6027588912$1425327071$gmane$org@efficios.com>
References: <CAM5kDqziReFDadtgHC76OfEgwtD7VFRh8y1Q6CCF4OYKOdHu6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0570951857=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Jonathan.rajotte-julien@efficios.com>)
 id 1YSWfQ-0000W6-EL
 for lttng-dev@lists.lttng.org; Mon, 02 Mar 2015 15:10:19 -0500
In-Reply-To: <CAM5kDqziReFDadtgHC76OfEgwtD7VFRh8y1Q6CCF4OYKOdHu6A@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Anand Neeli <anand.neeli@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--===============0570951857==
Content-Type: multipart/alternative;
 boundary="------------020901050000020101030300"

This is a multi-part message in MIME format.
--------------020901050000020101030300
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey Anand,

I just checkout tag v1.2.4 from git and lttng-live format is present and 
supported.
Are you sure that you are using 1.2.4? You can check this simply by 
running babeltrace without argument.

Cheers!

On 15-03-02 02:51 PM, Anand Neeli wrote:
> Hi All,
> I'm using BabelTrace Trace Viewer and Converter 1.2.4
> and i see the available formats are ctf, text.
>
> node-a # babeltrace -l
> Formats available: ctf, text.
>
> How do i get lttng-live support? i read somewhere that "babeltrace -i 
> lttng-live"  can be used to read live tracing data, but looks like 
> this option is not available in 1.2.4
> am i missing anything here?
>
> Thanks,
> Anand Neeli
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Jonathan R. Julien
Efficios


--------------020901050000020101030300
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3DISO-8859-1"
      http-equiv=3D"Content-Type">
  </head>
  <body>
    Hey Anand,<br>
    <br>
    I just checkout tag v1.2.4 from git and lttng-live format is present
    and supported.<br>
    Are you sure that you are using 1.2.4? You can check this simply by
    running babeltrace without argument.<br>
    <br>
    Cheers!<br>
    <br>
    <div class=3D"moz-cite-prefix">On 15-03-02 02:51 PM, Anand Neeli
      wrote:<br>
    </div>
    <blockquote
cite=3D"mid:CAM5kDqziReFDadtgHC76OfEgwtD7VFRh8y1Q6CCF4OYKOdHu6A@mail.gmai=
l.com"
      type=3D"cite">
      <div dir=3D"ltr">
        <div>Hi All,</div>
        <div>
          <div>I'm using BabelTrace Trace Viewer and Converter 1.2.4</div=
>
        </div>
        <div>and i see the available formats are ctf, text.</div>
        <div><br>
        </div>
        <div>
          <div>node-a # babeltrace -l =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=
=A0</div>
          <div>Formats available: ctf, text.<br>
          </div>
        </div>
        <div><br>
        </div>
        <div>How do i get lttng-live support? i read somewhere that
          "babeltrace -i lttng-live" =C2=A0can be used to read live traci=
ng
          data, but looks like this option is not available in 1.2.4</div=
>
        <div>am i missing anything here?</div>
        <div><br>
        </div>
        <div>Thanks,</div>
        <div>Anand Neeli</div>
        <div><br>
        </div>
      </div>
      <br>
      <fieldset class=3D"mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap=3D"">_______________________________________________
lttng-dev mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:lttng-dev@lists.lttn=
g.org">lttng-dev@lists.lttng.org</a>
<a class=3D"moz-txt-link-freetext" href=3D"http://lists.lttng.org/cgi-bin=
/mailman/listinfo/lttng-dev">http://lists.lttng.org/cgi-bin/mailman/listi=
nfo/lttng-dev</a>
</pre>
    </blockquote>
    <br>
    <pre class=3D"moz-signature" cols=3D"72">--=20
Jonathan R. Julien
Efficios</pre>
  </body>
</html>

--------------020901050000020101030300--


--===============0570951857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0570951857==--
