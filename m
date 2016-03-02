From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Subject: Re: Segfault during process exit
Date: Wed, 2 Mar 2016 14:21:44 -0500
Message-ID: <56D73D48.3070700__14526.3200080537$1456946562$gmane$org@efficios.com>
References: <DM3PR13MB07829B1DB9D8EEE29BE9124BC7BC0@DM3PR13MB0782.namprd13.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0959952667=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Jonathan.rajotte-julien@efficios.com>)
 id 1abCLI-000488-HW
 for lttng-dev@lists.lttng.org; Wed, 02 Mar 2016 14:21:53 -0500
In-Reply-To: <DM3PR13MB07829B1DB9D8EEE29BE9124BC7BC0@DM3PR13MB0782.namprd13.prod.outlook.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jeffrey Chen <cpthk@live.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--===============0959952667==
Content-Type: multipart/alternative;
 boundary="------------010702070100000004070805"

This is a multi-part message in MIME format.
--------------010702070100000004070805
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Could you provide a reproducer ?

Could you give us some context ?

Thanks

On 2016-03-02 02:07 PM, Jeffrey Chen wrote:
>
> Hi:
>
>
> Our system process will spawn several background threads to do tasks. 
> During the process exit, there is no guarantee that these background 
> threads are finished. I have noticed several times that the execution 
> would segfault during exiting. The stacktrace is showing that the 
> segfault happened at the call to write trace, tracepoint(). My guess 
> is that LTTng cleaned up the tracing connection, and the background 
> thread was still running. Has anyone noticed this issue? I thought 
> about trying wait for all the background threads to complete, but this 
> is very difficult to do in a complex system, as the background thread 
> could spawn more threads during the process. Is there any way to solve 
> this? Thanks.
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


--------------010702070100000004070805
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3DISO-8859-1"
      http-equiv=3D"Content-Type">
  </head>
  <body>
    Hi,<br>
    <br>
    Could you provide a reproducer ?<br>
    <br>
    Could you give us some context ?<br>
    <br>
    Thanks<br>
    <br>
    <div class=3D"moz-cite-prefix">On 2016-03-02 02:07 PM, Jeffrey Chen
      wrote:<br>
    </div>
    <blockquote
cite=3D"mid:DM3PR13MB07829B1DB9D8EEE29BE9124BC7BC0@DM3PR13MB0782.namprd13=
.prod.outlook.com"
      type=3D"cite">
      <meta http-equiv=3D"Content-Type" content=3D"text/html;
        charset=3DISO-8859-1">
      <style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top=
:0;margin-bottom:0;} --></style>
      <div id=3D"divtagdefaultwrapper"
style=3D"font-size:12pt;color:#000000;background-color:#FFFFFF;font-famil=
y:Calibri,Arial,Helvetica,sans-serif;">
        <p>Hi:</p>
        <p><br>
        </p>
        <p>Our system process will spawn several background threads to
          do tasks. During the process exit, there is no guarantee that
          these background threads are finished. I have noticed several
          times that the execution would segfault during exiting. The
          stacktrace is showing that the segfault happened at the call
          to write trace, tracepoint(). My guess is that LTTng cleaned
          up the tracing connection, and the background thread was still
          running. Has anyone noticed this issue?=C2=A0I thought about tr=
ying
          wait for all the background threads to complete, but this is
          very difficult to do in a complex system, as the background
          thread could spawn more threads during the process.
          <span id=3D"ms-rterangepaste-start"></span>Is there any way to
          solve this? <span id=3D"ms-rterangepaste-end">
          </span>Thanks.<br>
        </p>
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

--------------010702070100000004070805--


--===============0959952667==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0959952667==--
