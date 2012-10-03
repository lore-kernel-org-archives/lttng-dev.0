From: Bernd Hufmann <bernd.hufmann@ericsson.com>
Subject: LTTng Tools 2.1 streaming commands
Date: Wed, 3 Oct 2012 14:17:23 -0400
Message-ID: <4CB817F8B8860343821834C09BFBA7A6E183805D4D__21036.0118923292$1349288618$gmane$org@EUSAACMS0702.eamcs.ericsson.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1847692290=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from imr4.ericy.com ([198.24.6.9])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <bernd.hufmann@ericsson.com>) id 1TJTVj-0007uS-CA
	for lttng-dev@lists.lttng.org; Wed, 03 Oct 2012 14:17:31 -0400
Received: from eusaamw0712.eamcs.ericsson.se ([147.117.20.181])
	by imr4.ericy.com (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id
	q93IOdwu007112
	for <lttng-dev@lists.lttng.org>; Wed, 3 Oct 2012 13:24:48 -0500
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1847692290==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_4CB817F8B8860343821834C09BFBA7A6E183805D4DEUSAACMS0702e_"

--_000_4CB817F8B8860343821834C09BFBA7A6E183805D4DEUSAACMS0702e_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello

For the support of LTTng Tools 2.1 in Eclipse, I'm currently trying to unde=
rstand how to use the configuration for network streaming with the updated =
"lttng create"-command and new "enable-consumer"-command.

a) lttng enable-consumer
I find this command confusing because this command does not always enables =
the consumer, even if the command name implies so. The enabling actually de=
pends on how the command is executed.
Examples:
*       "lttng enable-consumer -k -U net://<remote_addr>" or "lttng enable-=
consumer -k -C tcp://<remote_addr> -D tcp://<remote_addr>" don't enable the=
 consumer. You need to either add option --enable or execute subsequently "=
lttng enable-consumer --enable"
*       lttng enable-consumer -k net://<remote_addr> does enable the consum=
er. I took me a while to figure out the difference to the example above: Th=
e option -U is omitted.

What the command actually provides, is 2 features: A way to configure strea=
ming (e.g. remote_addr) and a way to enable the consumer. Would it be bette=
r to name it to "lttng configure-consumer"? Also, remove the support of the=
 possibility to not specify -U, -C or -D. The following variants of this co=
mmand should be enough:
lttng configure-consumer -k -U <remote_addr> [--enable]
lttng configure-consumer -k -C <remote_addr> -D <remote_addr> [--enable]
lttng configure-consumer -k --enable
lttng configure-consumer -u -U <remote_addr> [--enable]
lttng configure-consumer -u -C <remote_addr> -D <remote_addr> [--enable]
lttng configure-consumer -u --enable

Please let me know what you think.

b) lttng create [-U <remote_addr>] | [-C <remote_addr> -D <remote_addr>] [-=
-no-consumer] [--disable-consumer]
*       Are options --no-consumer or --disable-consumer only applicable for=
 streaming?
*       I'm not sure what is the purpose of the options --no-consumer or --=
disable-consumer. Could you please explain the use cases for using --no-con=
sumer or --disable-consumer?

Thanks
Bernd

This Communication is Confidential. We only send and receive email on the b=
asis of the terms set out at www.ericsson.com/email_disclaimer



--_000_4CB817F8B8860343821834C09BFBA7A6E183805D4DEUSAACMS0702e_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Arial, sans-serif" size=3D"2">
<div>Hello</div>
<div>&nbsp;</div>
<div>For the support of LTTng Tools 2.1 in Eclipse, I'm currently trying to=
 understand how to use the configuration for network streaming with the upd=
ated &quot;lttng create&quot;-command and new &quot;enable-consumer&quot;-c=
ommand.</div>
<div>&nbsp;</div>
<div style=3D"padding-left: 19pt; text-indent: -19pt; ">a) lttng enable-con=
sumer</div>
<div style=3D"padding-left: 19pt; text-indent: -19pt; ">I find this command=
 confusing because this command does not always enables the consumer, even =
if the command name implies so. The enabling actually depends on how the co=
mmand is executed. </div>
<div style=3D"padding-left: 19pt; text-indent: -19pt; ">Examples:</div>
<ul style=3D"margin-top: 0pt; margin-bottom: 0pt; margin-left: 38pt; ">
<li>&quot;lttng enable-consumer -k -U net://&lt;remote_addr&gt;&quot; or &q=
uot;lttng enable-consumer -k -C tcp://&lt;remote_addr&gt; -D tcp://&lt;remo=
te_addr&gt;&quot; don't enable the consumer. You need to either add option =
--enable or execute subsequently &quot;lttng enable-consumer --enable&quot;=
</li><li>lttng enable-consumer -k net://&lt;remote_addr&gt; does enable the=
 consumer. I took me a while to figure out the difference to the example ab=
ove: The option -U is omitted.</li></ul>
<div>&nbsp;</div>
<div style=3D"padding-left: 19pt; text-indent: -19pt; ">What the command ac=
tually provides, is 2 features: A way to configure streaming (e.g. remote_a=
ddr) and a way to enable the consumer. Would it be better to name it to &qu=
ot;lttng configure-consumer&quot;? Also, remove
the support of the possibility to not specify -U, -C or -D. The following v=
ariants of this command should be enough:</div>
<div style=3D"padding-left: 19pt; text-indent: -19pt; ">lttng configure-con=
sumer -k -U &lt;remote_addr&gt; [--enable]</div>
<div style=3D"padding-left: 19pt; text-indent: -19pt; ">lttng configure-con=
sumer -k -C &lt;remote_addr&gt; -D &lt;remote_addr&gt; [--enable]</div>
<div style=3D"padding-left: 19pt; text-indent: -19pt; ">lttng configure-con=
sumer -k --enable</div>
<div style=3D"padding-left: 19pt; text-indent: -19pt; ">lttng configure-con=
sumer -u -U &lt;remote_addr&gt; [--enable]</div>
<div style=3D"padding-left: 19pt; text-indent: -19pt; ">lttng configure-con=
sumer -u -C &lt;remote_addr&gt; -D &lt;remote_addr&gt; [--enable]</div>
<div style=3D"padding-left: 19pt; text-indent: -19pt; ">lttng configure-con=
sumer -u --enable</div>
<div style=3D"padding-left: 19pt; text-indent: -19pt; ">&nbsp;</div>
<div style=3D"padding-left: 19pt; text-indent: -19pt; ">Please let me know =
what you think.</div>
<div style=3D"padding-left: 19pt; text-indent: -19pt; ">&nbsp;</div>
<div style=3D"padding-left: 19pt; text-indent: -19pt; ">b) lttng create [-U=
 &lt;remote_addr&gt;] | [-C &lt;remote_addr&gt; -D &lt;remote_addr&gt;] [--=
no-consumer] [--disable-consumer]</div>
<ul style=3D"margin-top: 0pt; margin-bottom: 0pt; margin-left: 38pt; ">
<li>Are options --no-consumer or --disable-consumer only applicable for str=
eaming?</li><li>I'm not sure what is the purpose of the options --no-consum=
er or --disable-consumer. Could you please explain the use cases for using =
--no-consumer or --disable-consumer? </li></ul>
<div>&nbsp;</div>
<div>Thanks</div>
<div>Bernd</div>
<div>&nbsp;</div>
<div><font face=3D"Arial, sans-serif">This Communication is Confidential. W=
e only send and receive email on the basis of the terms set out at <a href=
=3D"www.ericsson.com/email_disclaimer"><font color=3D"#0000FF"><u>www.erics=
son.com/email_disclaimer</u></font></a></font></div>
<div><font face=3D"Arial, sans-serif">&nbsp;</font></div>
<div>&nbsp;</div>
</font>
</body>
</html>

--_000_4CB817F8B8860343821834C09BFBA7A6E183805D4DEUSAACMS0702e_--


--===============1847692290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1847692290==--
