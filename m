From: Vlad <vlad@demoninsight.com>
Subject: Re: What is the size overhead of UST tracepoints?
	(hint: very large indeed)
Date: Tue, 29 Oct 2013 10:32:55 -0400
Message-ID: <A651D048-3BA0-419E-9A6A-9EDED86ED34C__23185.072563547$1383057253$gmane$org@demoninsight.com>
References: <OF98A3476E.B164A434-ONC2257C13.003269EB-C2257C13.00354EB7@il.ibm.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/mixed; boundary="===============0631390140=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <vlad@demoninsight.com>) id 1VbALv-0006CH-55
	for lttng-dev@lists.lttng.org; Tue, 29 Oct 2013 10:33:08 -0400
Received: by mail-qa0-f47.google.com with SMTP id k15so2925985qaq.20
	for <lttng-dev@lists.lttng.org>; Tue, 29 Oct 2013 07:32:57 -0700 (PDT)
Received: from [10.52.5.106] (msmc-64-72-75-194.customer.hvdata.net.
	[64.72.75.194])
	by mx.google.com with ESMTPSA id r5sm65733881qaj.13.2013.10.29.07.32.55
	for <lttng-dev@lists.lttng.org>
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Tue, 29 Oct 2013 07:32:56 -0700 (PDT)
In-Reply-To: <OF98A3476E.B164A434-ONC2257C13.003269EB-C2257C13.00354EB7@il.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org


--===============0631390140==
Content-Type: multipart/alternative; boundary="Apple-Mail=_B7594D2C-0E5F-448B-B823-166B8BC3B40F"


--Apple-Mail=_B7594D2C-0E5F-448B-B823-166B8BC3B40F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


On Oct 29, 2013, at 4:42 AM, Amit Margalit <AMITM@il.ibm.com> wrote:

> Additionally, there is a ton of code to calculate the event size, its =
alignment, and to verify that the names are not longer than the 256 byte =
buffer, and more.=20

A couple of thoughts:

(a) there may be a way to share fewer definitions of events across more =
event emit sites. Especially if LTTng supported optional/missing fields =
:) For example, define a single "function.entry" and a single =
"function.exit" instead of a unique definition for each function you =
have. Disambiguate using a parameter.

(b) this is not something that could be done in kernel but in a C++ user =
app it's fairly easy to statically compute everything that depends on =
information known at compile time. I use a custom EDSL implemented via =
boost.proto. As a result, only the stuff that gets used is embedded in =
object code and all event emit calls inline in very fast assembly that's =
optimal for each particular combination of actual argument values.

Cheers,
Vlad=

--Apple-Mail=_B7594D2C-0E5F-448B-B823-166B8BC3B40F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dus-ascii"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space; =
"><br><div><div>On Oct 29, 2013, at 4:42 AM, Amit Margalit &lt;<a =
href=3D"mailto:AMITM@il.ibm.com">AMITM@il.ibm.com</a>&gt; =
wrote:</div><br class=3D"Apple-interchange-newline"><blockquote =
type=3D"cite"><font size=3D"2" face=3D"sans-serif" style=3D"font-style: =
normal; font-variant: normal; font-weight: normal; letter-spacing: =
normal; line-height: normal; orphans: 2; text-align: -webkit-auto; =
text-indent: 0px; text-transform: none; white-space: normal; widows: 2; =
word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px; ">Additionally, there is a ton of code =
to calculate the event size, its alignment, and to verify that the names =
are not longer than the 256 byte buffer, and more.</font><span =
style=3D"font-family: Helvetica; font-size: medium; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: 2; text-align: -webkit-auto; text-indent: =
0px; text-transform: none; white-space: normal; widows: 2; word-spacing: =
0px; -webkit-text-size-adjust: auto; -webkit-text-stroke-width: 0px; =
display: inline !important; float: none; =
">&nbsp;</span></blockquote></div><br><div>A couple of =
thoughts:</div><div><br></div><div>(a) there may be a way to share fewer =
definitions of events across more event emit sites. Especially if LTTng =
supported optional/missing fields :) For example, define a single =
"function.entry" and a single "function.exit" instead of a unique =
definition for each function you have. Disambiguate using a =
parameter.</div><div><br></div><div>(b) this is not something that could =
be done in kernel but in a C++ user app it's fairly easy to statically =
compute everything that depends on information known at compile time. I =
use a custom EDSL implemented via boost.proto. As a result, only the =
stuff that gets used is embedded in object code and all event emit calls =
inline in very fast assembly that's optimal for each particular =
combination of actual argument =
values.</div><div><br></div><div>Cheers,</div><div>Vlad</div></body></html=
>=

--Apple-Mail=_B7594D2C-0E5F-448B-B823-166B8BC3B40F--


--===============0631390140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0631390140==--
