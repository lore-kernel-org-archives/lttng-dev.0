From: Hollis Blanchard <hollis_blanchard@mentor.com>
Subject: Re: New tracef() feature in LTTng-UST
Date: Mon, 17 Mar 2014 10:28:55 -0700
Message-ID: <532730D7.4030509__11150.955889798$1395077408$gmane$org@mentor.com>
References: <138917049.3594.1394830210179.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0435375247=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Hollis_Blanchard@mentor.com>) id 1WPbLT-00009p-8W
	for lttng-dev@lists.lttng.org; Mon, 17 Mar 2014 13:29:08 -0400
In-Reply-To: <138917049.3594.1394830210179.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0435375247==
Content-Type: multipart/alternative;
	boundary="------------000702080503060904090808"

--------------000702080503060904090808
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.polymtl.ca id s2HHTX1V030362

On 03/14/2014 01:50 PM, Mathieu Desnoyers wrote:
> Hi everyone,
>
> I pushed a new features in LTTng-UST that I'm sure everyone will like.
>
> USAGE WITH TRACEF
>
>         The simplest way to add instrumentation to your  code  is  by  =
far  the
>         tracef() API. To you it, in a nutshell:
>
>         1) #include <lttng/tracef.h>
>
>         2) /* in your code, use like a printf */
>            tracef("my message, this integer %d", 1234);
>
>         3) Link your program against liblttng-ust.so.
>
>         4) Enable the UST event "lttng_ust_tracef:event" when tracing w=
ith the
>            following sequence of commands from lttng-tools:
>
>            lttng  create; lttng enable-event -u "lttng_ust_tracef:event=
"; lttng start
>            [... run your program ...]
>            lttng stop; lttng view
>
>         That's it!
>
>         If you want to have more flexibility and control on  the  event=
  names,
>         payload  typing,  etc,  you  can continue reading on and use th=
e trace=E2=80=90
>         points below. "tracef()" is there for quick and dirty ad hoc in=
strumen=E2=80=90
>         tation, whereas tracepoint.h is meant for thorough instrumentat=
ion of a
>         code base to be integrated with an upstream project.
>
> Feedback is welcome!

I haven't seen vocal support for this yet, so let me just say this is a=20
*very* welcome addition. Today, one of the first questions we get from=20
our customers is "how do I create new tracepoints in my code?", and=20
unfortunately that's almost always a very painful discussion. Having=20
this API available would be a big help.

Hollis Blanchard
Product Owner, Sourcery CodeBench <http://go.mentor.com/codebench> and=20
Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
Mentor Graphics Embedded Software Division


--------------000702080503060904090808
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.polymtl.ca id s2HHTX1V030362

<html>
  <head>
    <meta content=3D"text/html; charset=3DUTF-8" http-equiv=3D"Content-Ty=
pe">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <div class=3D"moz-cite-prefix">On 03/14/2014 01:50 PM, Mathieu
      Desnoyers wrote:<br>
    </div>
    <blockquote
      cite=3D"mid:138917049.3594.1394830210179.JavaMail.zimbra@efficios.c=
om"
      type=3D"cite">
      <pre wrap=3D"">Hi everyone,

I pushed a new features in LTTng-UST that I'm sure everyone will like.

USAGE WITH TRACEF

       The simplest way to add instrumentation to your  code  is  by  far=
  the
       tracef() API. To you it, in a nutshell:

       1) #include &lt;lttng/tracef.h&gt;

       2) /* in your code, use like a printf */
          tracef("my message, this integer %d", 1234);

       3) Link your program against liblttng-ust.so.

       4) Enable the UST event "lttng_ust_tracef:event" when tracing with=
 the
          following sequence of commands from lttng-tools:

          lttng  create; lttng enable-event -u "lttng_ust_tracef:event"; =
lttng start
          [... run your program ...]
          lttng stop; lttng view

       That's it!

       If you want to have more flexibility and control on  the  event  n=
ames,
       payload  typing,  etc,  you  can continue reading on and use the t=
race=E2=80=90
       points below. "tracef()" is there for quick and dirty ad hoc instr=
umen=E2=80=90
       tation, whereas tracepoint.h is meant for thorough instrumentation=
 of a
       code base to be integrated with an upstream project.

Feedback is welcome!
</pre>
    </blockquote>
    <br>
    I haven't seen vocal support for this yet, so let me just say this
    is a *very* welcome addition. Today, one of the first questions we
    get from our customers is "how do I create new tracepoints in my
    code?", and unfortunately that's almost always a very painful
    discussion. Having this API available would be a big help.<br>
    <br>
    <div class=3D"moz-signature">Hollis Blanchard<br>
      Product Owner, <a href=3D"http://go.mentor.com/codebench">Sourcery
        CodeBench</a> and <a
        href=3D"http://go.mentor.com/sourceryanalyzer">Sourcery Analyzer<=
/a><br>
      Mentor Graphics Embedded Software Division<br>
    </div>
    <br>
  </body>
</html>

--------------000702080503060904090808--


--===============0435375247==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0435375247==--
