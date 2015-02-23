From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Subject: Re: No trace data until app restart
Date: Mon, 23 Feb 2015 11:54:32 -0500
Message-ID: <54EB5B48.3020305__38537.9029474736$1424710555$gmane$org@efficios.com>
References: <CAM5kDqxFbM0TVXGuke9KO1KDrqJfUK3kXtCESkD9COT1C3mLQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0352578901=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Jonathan.rajotte-julien@efficios.com>)
 id 1YPwHJ-0007cN-El
 for lttng-dev@lists.lttng.org; Mon, 23 Feb 2015 11:54:46 -0500
In-Reply-To: <CAM5kDqxFbM0TVXGuke9KO1KDrqJfUK3kXtCESkD9COT1C3mLQA@mail.gmail.com>
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
--===============0352578901==
Content-Type: multipart/alternative;
 boundary="------------080903010405070302020200"

This is a multi-part message in MIME format.
--------------080903010405070302020200
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Anand

On 15-02-23 07:33 AM, Anand Neeli wrote:
> Hi All,
>
> I'm using 2.4.1 and i see following issue. Can anyone let me know if 
> there is/was a bug for this? or let me know if i'm doing anything 
> wrong here.
A quick note on lttng version. We just released version 2.6 thus the end 
of 2.4 support (aka no more bug fix and backport). I highly encourage 
you to move to a supported version such as 2.6 or 2.5.
The ideal case would be to build from source. See 
http://lttng.org/docs/#doc-building-from-source for more info.

Could you test the application against 2.5 or 2.6? If it still don't 
work we would need a dummy program you can share that replicate the 
problem with a step by step way to reproduce it.
 From there we could go forward.

Cheers!
>
> I have my app running, and now if i create a trace session then 
> nothing gets logged until the app is restarted.
> Also i have multiple session configured with same events enabled on 
> all sessions, but nothing gets logged into any of the sessions until 
> the app is restarted.
>
> I'm using following commands.
>
> lttng-sessiond --consumerd32-path 
> /usr/lib/lttng/libexec/lttng-consumerd --consumerd32-libdir /usr/lib/ 
> --consumerd64-path /usr/lib64/lttng/libexec/lttng-consumerd 
> --consumerd64-libdir /usr/lib64/ -b --no-kernel
>
> lttng  --no-sessiond create mys5
> lttng enable-channel myc5 --userspace --buffers-pid -s mys5 
> --tracefile-size 8388608 --tracefile-count 8
> lttng enable-event --channel myc5 --userspace --all --exclude 
> 'ust_libc:*' -s mys5
> lttng start mys5
>
>
> Thanks,
> Anand Neeli
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Jonathan R. Julien
Efficios


--------------080903010405070302020200
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3DISO-8859-1"
      http-equiv=3D"Content-Type">
  </head>
  <body>
    Hi Anand<br>
    <br>
    <div class=3D"moz-cite-prefix">On 15-02-23 07:33 AM, Anand Neeli
      wrote:<br>
    </div>
    <blockquote
cite=3D"mid:CAM5kDqxFbM0TVXGuke9KO1KDrqJfUK3kXtCESkD9COT1C3mLQA@mail.gmai=
l.com"
      type=3D"cite">
      <div dir=3D"ltr">Hi All,
        <div><br>
        </div>
        <div>I'm using 2.4.1 and i see following issue. Can anyone let
          me know if there is/was a bug for this? or let me know if i'm
          doing anything wrong here.</div>
      </div>
    </blockquote>
    A quick note on lttng version. We just released version 2.6 thus the
    end of 2.4 support (aka no more bug fix and backport). I highly
    encourage you to move to a supported version such as 2.6 or 2.5.<br>
    The ideal case would be to build from source. See
    <a class=3D"moz-txt-link-freetext" href=3D"http://lttng.org/docs/#doc=
-building-from-source">http://lttng.org/docs/#doc-building-from-source</a=
> for more info.<br>
    <br>
    Could you test the application against 2.5 or 2.6? If it still don't
    work we would need a dummy program you can share that replicate the
    problem with a step by step way to reproduce it.<br>
    From there we could go forward.<br>
    <br>
    Cheers! <br>
    <blockquote
cite=3D"mid:CAM5kDqxFbM0TVXGuke9KO1KDrqJfUK3kXtCESkD9COT1C3mLQA@mail.gmai=
l.com"
      type=3D"cite">
      <div dir=3D"ltr">
        <div><br>
        </div>
        <div>I have my app running, and now if i create a trace session
          then nothing gets logged until the app is restarted.</div>
        <div>Also i have multiple session configured with same events
          enabled on all sessions, but nothing gets logged into any of
          the sessions until the app is restarted.<br>
        </div>
        <div>
          <div><br>
          </div>
          <div>I'm using following commands.</div>
          <div>
            <p class=3D"">lttng-sessiond --consumerd32-path
              /usr/lib/lttng/libexec/lttng-consumerd
              --consumerd32-libdir /usr/lib/ --consumerd64-path
              /usr/lib64/lttng/libexec/lttng-consumerd
              --consumerd64-libdir /usr/lib64/ -b --no-kernel=C2=A0</p>
          </div>
          <div>lttng=C2=A0 --no-sessiond create mys5</div>
          <div>lttng enable-channel myc5 --userspace --buffers-pid -s
            mys5 --tracefile-size 8388608 --tracefile-count 8</div>
          <div>lttng enable-event --channel myc5 --userspace --all <span
              class=3D"">--exclude 'ust_libc:*'</span> -s mys5</div>
          <div>lttng start mys5</div>
        </div>
        <div><br>
        </div>
        <div><br>
        </div>
        <div>Thanks,</div>
        <div>Anand Neeli</div>
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
    <pre class=3D"moz-signature" cols=3D"72">--=20
Jonathan R. Julien
Efficios</pre>
  </body>
</html>

--------------080903010405070302020200--


--===============0352578901==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0352578901==--
