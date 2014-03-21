From: Sandeep K Chaudhary <babbusandy2006@gmail.com>
Subject: Regarding Bug #633 - utils_parse_size_suffix suffers
	from several problems
Date: Fri, 21 Mar 2014 00:22:57 -0700
Message-ID: <CAEEAEzW+g222Z1Lhem2W=UpVrNnc7m+=4OULcRXH3J1gqmYqrw__38890.5658074238$1395386626$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0541201857=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <babbusandy2006@gmail.com>) id 1WQtnD-0008Tu-5P
	for lttng-dev@lists.lttng.org; Fri, 21 Mar 2014 03:23:04 -0400
Received: by mail-qg0-f47.google.com with SMTP id 63so5939579qgz.6
	for <lttng-dev@lists.lttng.org>; Fri, 21 Mar 2014 00:22:57 -0700 (PDT)
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

--===============0541201857==
Content-Type: multipart/alternative; boundary=001a11c2b34e4a434d04f518c1c9

--001a11c2b34e4a434d04f518c1c9
Content-Type: text/plain; charset=ISO-8859-1

Hi guys,

I checked the fix suggested in the bug description and it is correct.

Changing

ret = regcomp(&regex, "^\\(0x\\)\\{0,1\\}[0-9][0-9]*\\([kKMG]\\{0,1\\}\\)$", 0);

to

ret = regcomp(&regex,
"^(((0x|0X)[0-9A-Fa-f]+)|(0[0-7]*)|([1-9][0-9]*))[kKMG]?$", REG_EXTENDED);

will take care of the following three problems that exist in the first regex


   - It accepts a leading 0 (without a following x or X) to represent an
   octal value, but simultaneously accepts the digits 8 and 9 in said octal
   value (this yields -1).
   - It does not support the leading 0X hexadecimal indicator but does
   support a leading 0x (see following).
   - It accepts a leading 0x to represent an hexadecimal value but rejects
   the a..f and A..F digits in said value.


Please let me know your views, and then I can submit a patch for this.

Thanks and regards,
Sandeep.

--001a11c2b34e4a434d04f518c1c9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi guys,<div><br></div><div>I checked the fix suggested in=
 the bug description and it is correct.</div><div><br></div><div>Changing</=
div><div><div><pre style=3D"margin-right:1em;margin-left:1.6em;padding:2px =
2px 2px 0px;background-color:rgb(250,250,250);border:1px solid rgb(218,218,=
218);width:auto;color:rgb(72,72,72);font-size:12px">
ret =3D regcomp(&amp;regex, &quot;^\\(0x\\)\\{0,1\\}[0-9][0-9]*\\([kKMG]\\{=
0,1\\}\\)$&quot;, 0);</pre></div></div><div>to&nbsp;</div><div><br></div><d=
iv><span style=3D"color:rgb(72,72,72);font-family:monospace;font-size:12px;=
white-space:pre;background-color:rgb(250,250,250)">ret =3D regcomp(&amp;reg=
ex, &quot;^(((0x|0X)[0-9A-Fa-f]+)|(0[0-7]*)|([1-9][0-9]*))[kKMG]?$&quot;, R=
EG_EXTENDED);</span><br>
</div><div><span style=3D"color:rgb(72,72,72);font-family:monospace;font-si=
ze:12px;white-space:pre;background-color:rgb(250,250,250)"><br></span></div=
><div><span style=3D"color:rgb(72,72,72);font-family:monospace;font-size:12=
px;white-space:pre;background-color:rgb(250,250,250)">will take care of the=
 </span>following three problems that exist in the first regex</div>
<div><br></div><div><ul style=3D"margin-bottom:1em;color:rgb(72,72,72);font=
-family:Verdana,sans-serif;font-size:12px;background-color:rgb(255,255,221)=
"><li>It accepts a leading 0 (without a following x or X) to represent an o=
ctal value, but simultaneously accepts the digits 8 and 9 in said octal val=
ue (this yields &ndash;1).</li>
<li>It does not support the leading 0X hexadecimal indicator but does suppo=
rt a leading 0x (see following).</li><li>It accepts a leading 0x to represe=
nt an hexadecimal value but rejects the a..f and A..F digits in said value.=
</li>
</ul></div><div><br></div><div>Please let me know your views, and then I ca=
n submit a patch for this.</div><div><br></div><div>Thanks and regards,</di=
v><div>Sandeep.</div><div><br></div></div>

--001a11c2b34e4a434d04f518c1c9--


--===============0541201857==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0541201857==--
