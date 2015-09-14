From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Lttng tracepoint(provider,tpname, arg)
Date: Mon, 14 Sep 2015 18:17:41 +0000 (UTC)
Message-ID: <572965168.6604.1442254661232.JavaMail.zimbra__4431.99535734511$1442254730$gmane$org@efficios.com>
References: <D199CBB1905D6A4E83FFCD29C335DF4C3B69BA49@NLEIDX740.sn-eu.asml.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1332571783=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZbYKF-0001ZT-VT
 for lttng-dev@lists.lttng.org; Mon, 14 Sep 2015 14:18:02 -0400
In-Reply-To: <D199CBB1905D6A4E83FFCD29C335DF4C3B69BA49@NLEIDX740.sn-eu.asml.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Farhan Shariff <farhan.shariff@asml.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1332571783==
Content-Type: multipart/alternative;
	boundary="----=_Part_6603_693627043.1442254661227"

------=_Part_6603_693627043.1442254661227
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- On Sep 14, 2015, at 4:51 AM, Farhan Shariff <farhan.shariff@asml.com> wrote: 

> I want to insert tracepoint statements with same traceprovider_name and
> tracepoint_name but with different arguments:

> for example:

> hello-tp.tp

> TRACEPOINT_EVENT(
> provider_name_test,
> tp_name_tp,
> TP_ARGS(
> int, my_integer_arg,
> char*, my_string_arg
> ),
> TP_FIELDS(
> ctf_string(my_string_field, my_string_arg)
> ctf_integer(int, my_integer_field, my_integer_arg)
> )
> )

> How to use these in the code:

> tracepoint(provider_name_test, tp_name_tp,23 )

> tracepoint(provider_name_test, tp_name_tp,"hi there" )

> tracepoint(provider_name_test, tp_name_tp,23, "hi there" )

Don't do this, this is not supported. Use different names. 

Thanks, 

Mathieu 

> Best regards / Met vriendelijke groet / Cordialement,

> Farhan Shariff

> EUV Source Software Facilites

> Development & Engineering

> ASML Netherlands B.V. | De Run 6501 | 5504 DR Veldhoven | The Netherlands
> Location: 7G2 | Tel: +31 619084549
> farhan.shariff@asml.com | www.asml.com
> -- The information contained in this communication and any attachments is
> confidential and may be privileged, and is for the sole use of the intended
> recipient(s). Any unauthorized review, use, disclosure or distribution is
> prohibited. Unless explicitly stated otherwise in the body of this
> communication or the attachment thereto (if any), the information is provided
> on an AS-IS basis without any express or implied warranties or liabilities. To
> the extent you are relying on this information, you are doing so at your own
> risk. If you are not the intended recipient, please notify the sender
> immediately by replying to this message and destroy all copies of this message
> and any attachments. The sender nor the company/group of companies he or she
> represents shall be liable for the proper and complete transmission of the
> information contained in this communication, or for any delay in its receipt.
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_6603_693627043.1442254661227
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html><body><div style="font-family: arial, helvetica, sans-serif; font-size: 12pt; color: #000000"><div><span id="zwchr" data-marker="__DIVIDER__">----- On Sep 14, 2015, at 4:51 AM, Farhan Shariff &lt;farhan.shariff@asml.com&gt; wrote:<br></span></div><div data-marker="__QUOTED_TEXT__"><blockquote style="border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><style><!--

@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Verdana;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:Vijaya;
	panose-1:2 11 6 4 2 2 2 2 2 4;}

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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><div class="WordSection1"><p class="MsoNormal"><span style="color:#444444;background:white">&nbsp;I want to insert tracepoint statements with same traceprovider_name and</span><span style="color:#444444"><br>
<span style="background:white">&nbsp;&nbsp;tracepoint_name but with different arguments:</span><br>
<span style="background:white">&nbsp;</span></span></p><p class="MsoNormal"><span style="color:#444444;background:white">&nbsp;</span></p><p class="MsoNormal"><span style="color:#444444;background:white">&nbsp;for example:</span><span style="color:#444444"><br>
<span style="background:white">&nbsp;</span><br>
<span style="background:white">&nbsp;&nbsp;hello-tp.tp</span><br>
<span style="background:white">&nbsp;</span><br>
<span style="background:white">&nbsp;&nbsp;TRACEPOINT_EVENT(</span><br>
<span style="background:white">&nbsp;&nbsp;provider_name_test,</span><br>
<span style="background:white">&nbsp;&nbsp;tp_name_tp,</span><br>
<span style="background:white">&nbsp;&nbsp;TP_ARGS(</span><br>
<span style="background:white">&nbsp;&nbsp;int, my_integer_arg,</span><br>
<span style="background:white">&nbsp;&nbsp;char*, my_string_arg</span><br>
<span style="background:white">&nbsp;&nbsp;),</span><br>
<span style="background:white">&nbsp;&nbsp;TP_FIELDS(</span><br>
<span style="background:white">&nbsp;&nbsp;ctf_string(my_string_field, my_string_arg)</span><br>
<span style="background:white">&nbsp;&nbsp;ctf_integer(int, my_integer_field, my_integer_arg)</span><br>
<span style="background:white">&nbsp;&nbsp;)</span><br>
<span style="background:white">&nbsp;&nbsp;)</span><br>
<span style="background:white">&nbsp;</span><br>
<span style="background:white">&nbsp;&nbsp;How to use these in the code:</span><br>
<span style="background:white">&nbsp;</span><br>
<span style="background:white">&nbsp;&nbsp;tracepoint(provider_name_test, tp_name_tp,23 )</span><br>
<span style="background:white">&nbsp;</span><br>
<span style="background:white">&nbsp;&nbsp;tracepoint(provider_name_test, tp_name_tp,"hi there" )</span><br>
<span style="background:white">&nbsp;</span><br>
<span style="background:white">&nbsp;&nbsp;tracepoint(provider_name_test, tp_name_tp,23, "hi there" )</span></span></p></div></blockquote><div>Don't do this, this is not supported. Use different names.<br></div><div><br data-mce-bogus="1"></div><div>Thanks,<br data-mce-bogus="1"></div><div><br data-mce-bogus="1"></div><div>Mathieu</div><div><br data-mce-bogus="1"></div><blockquote style="border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt;"><div class="WordSection1"><p class="MsoNormal"><span style="color:#444444">
<span style="background:white">&nbsp;</span><br>
<span style="background:white">&nbsp;</span><br>
<span style="background:white">&nbsp;</span></span></p><p class="MsoNormal"><span style="font-family:&quot;Arial&quot;,&quot;sans-serif&quot;" lang="NL">Best regards / Met vriendelijke groet / Cordialement,</span></p><p class="MsoNormal"><b><span style="font-size:9.0pt;font-family:&quot;Verdana&quot;,&quot;sans-serif&quot;">&nbsp;</span></b></p><p class="MsoNormal"><b><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">Farhan Shariff
</span></b></p><p class="MsoNormal"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">EUV Source Software Facilites
</span></p><p class="MsoNormal"><span style="font-size:10.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">Development &amp; Engineering
</span></p><p class="MsoNormal"><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;">ASML Netherlands B.V. | De Run 6501 | 5504 DR Veldhoven | The Netherlands<br>
Location: 7G2 | Tel: +31 619084549</span><span style="font-size:8.0pt"><br>
</span><span style="font-size:8.0pt;font-family:&quot;Arial&quot;,&quot;sans-serif&quot;"><a href="farhan.shariff@asml.com%20" target="_blank"><span style="color:blue">farhan.shariff@asml.com</span></a> |
<a href="http://www.asml.com/" target="_blank"><span style="color:blue">www.asml.com</span></a></span></p></div>
-- The information contained in this communication and any attachments is confidential and may be privileged, and is for the sole use of the intended recipient(s). Any unauthorized review, use, disclosure or distribution is prohibited. Unless explicitly stated
 otherwise in the body of this communication or the attachment thereto (if any), the information is provided on an AS-IS basis without any express or implied warranties or liabilities. To the extent you are relying on this information, you are doing so at your
 own risk. If you are not the intended recipient, please notify the sender immediately by replying to this message and destroy all copies of this message and any attachments. The sender nor the company/group of companies he or she represents shall be liable
 for the proper and complete transmission of the information contained in this communication, or for any delay in its receipt.


<br>_______________________________________________<br>lttng-dev mailing list<br>lttng-dev@lists.lttng.org<br>http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></blockquote></div><div><br></div><div data-marker="__SIG_POST__">-- <br></div><div>Mathieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com</div></div></body></html>
------=_Part_6603_693627043.1442254661227--


--===============1332571783==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1332571783==--
