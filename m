From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: some questions on lttng
Date: Fri, 20 Jul 2012 08:39:14 +0200
Message-ID: <5008FD12.4040803__26851.2133196511$1342766380$gmane$org@mentor.com>
References: <4B3E7C3D6AE874479212F4D6AE0AFD1F02C7FF0741@MX28A.corp.emc.com>
	<4B3E7C3D6AE874479212F4D6AE0AFD1F02C7FF0805@MX28A.corp.emc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0472601471=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1Ss6re-00032T-CH
	for lttng-dev@lists.lttng.org; Fri, 20 Jul 2012 02:39:02 -0400
In-Reply-To: <4B3E7C3D6AE874479212F4D6AE0AFD1F02C7FF0805@MX28A.corp.emc.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Bingfeng.Zhao@emc.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0472601471==
Content-Type: multipart/alternative;
	boundary="------------040902000803050700000909"

--------------040902000803050700000909
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.polymtl.ca id q6K6d4Z6021743

On 07/20/2012 04:10 AM, Bingfeng.Zhao@emc.com wrote:
>
> Anyone can answer our questions? Mathieu?
>
> *From:*Bingfeng.Zhao@emc.com [mailto:Bingfeng.Zhao@emc.com]
> *Sent:* Wednesday, July 18, 2012 5:54 PM
> *To:* lttng-dev@lists.lttng.org
> *Subject:* [lttng-dev] some questions on lttng
>
> Hello the dev list,
>
> We encounter some basic questions when try to adapt the LTTNG in our=20
> poject.
>
> 1.When the trace is enabled and all are well configurated, we get=20
> trace messages collected under the session folder. The question is=20
> whether it is possible that some traces will lost when the trace=20
> messages are huge. How will LTTNG do if the consumer deamon cannot=20
> fast enough to copy the trace message from trace buffer?
>

I had similar concerns ...

http://lists.lttng.org/pipermail/lttng-dev/2012-April/017869.html
http://lists.lttng.org/pipermail/lttng-dev/2012-April/017835.html

AFAIK, there is no solution for this issue yet.

--
Paul

--=20
Paul Woegerer | SW Development Engineer
Mentor Embedded(tm) | Prinz Eugen Stra=DFe 72/2/4, Vienna, 1040 Austria
P 43.1.535991320
Nucleus=AE | Linux=AE | Android(tm) | Services | UI | Multi-OS

Android is a trademark of Google Inc. Use of this trademark is subject to=
 Google Permissions.
Linux is the registered trademark of Linus Torvalds in the U.S. and other=
 countries.


--------------040902000803050700000909
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 07/20/2012 04:10 AM,
      <a class="moz-txt-link-abbreviated" href="mailto:Bingfeng.Zhao@emc.com">Bingfeng.Zhao@emc.com</a> wrote:<br>
    </div>
    <blockquote
      cite="mid:4B3E7C3D6AE874479212F4D6AE0AFD1F02C7FF0805@MX28A.corp.emc.com"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html;
        charset=ISO-8859-1">
      <meta name="Generator" content="Microsoft Word 14 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:Verdana;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:"Verdana","sans-serif";
	color:windowtext;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Verdana","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1136877096;
	mso-list-type:hybrid;
	mso-list-template-ids:1808583752 67698703 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal"><span
style="font-family:&quot;Verdana&quot;,&quot;sans-serif&quot;;color:#1F497D">Anyone
            can answer our questions? Mathieu?<o:p></o:p></span></p>
        <p class="MsoNormal"><span
style="font-family:&quot;Verdana&quot;,&quot;sans-serif&quot;;color:#1F497D"><o:p>&nbsp;</o:p></span></p>
        <div>
          <div style="border:none;border-top:solid #B5C4DF
            1.0pt;padding:3.0pt 0in 0in 0in">
            <p class="MsoNormal"><b><span
style="font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;">From:</span></b><span
style="font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;">
                <a class="moz-txt-link-abbreviated" href="mailto:Bingfeng.Zhao@emc.com">Bingfeng.Zhao@emc.com</a> [<a class="moz-txt-link-freetext" href="mailto:Bingfeng.Zhao@emc.com">mailto:Bingfeng.Zhao@emc.com</a>] <br>
                <b>Sent:</b> Wednesday, July 18, 2012 5:54 PM<br>
                <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><br>
                <b>Subject:</b> [lttng-dev] some questions on lttng<o:p></o:p></span></p>
          </div>
        </div>
        <p class="MsoNormal"><o:p>&nbsp;</o:p></p>
        <p class="MsoNormal"><span
            style="font-family:&quot;Verdana&quot;,&quot;sans-serif&quot;">Hello
            the dev list,<o:p></o:p></span></p>
        <p class="MsoNormal"><span
            style="font-family:&quot;Verdana&quot;,&quot;sans-serif&quot;">We
            encounter some basic questions when try to adapt the LTTNG
            in our poject. <o:p></o:p></span></p>
        <p class="MsoListParagraph" style="text-indent: -0.25in;"><!--[if !supportLists]--><span
style="font-family:&quot;Verdana&quot;,&quot;sans-serif&quot;"><span
              style="mso-list:Ignore">1.<span style="font:7.0pt
                &quot;Times New Roman&quot;">&nbsp;&nbsp; </span></span></span><!--[endif]--><span
            style="font-family:
            &quot;Verdana&quot;,&quot;sans-serif&quot;;">When the trace
            is enabled and all are well configurated, we get trace
            messages collected under the session folder. The question is
            whether it is possible that some traces will lost when the
            trace messages are huge. How will LTTNG do if the consumer
            deamon cannot fast enough to copy the trace message from
            trace buffer?</span></p>
      </div>
    </blockquote>
    <br>
    I had similar concerns ...<br>
    <br>
    <a class="moz-txt-link-freetext"
      href="http://lists.lttng.org/pipermail/lttng-dev/2012-April/017869.html">http://lists.lttng.org/pipermail/lttng-dev/2012-April/017869.html</a><br>
    <a class="moz-txt-link-freetext"
      href="http://lists.lttng.org/pipermail/lttng-dev/2012-April/017835.html">http://lists.lttng.org/pipermail/lttng-dev/2012-April/017835.html</a><br>
    <br>
    AFAIK, there is no solution for this issue yet.<br>
    <br>
    --<br>
    Paul<br>
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

--------------040902000803050700000909--


--===============0472601471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0472601471==--
