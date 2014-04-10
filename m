From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: [PATCH lttng-tools] utils: Rework
 utils_parse_size_suffix
Date: Thu, 10 Apr 2014 20:22:42 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD3599C159__31087.7995835201$1397161428$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WYLUl-0003sI-KU
 for lttng-dev@lists.lttng.org; Thu, 10 Apr 2014 16:22:53 -0400
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

----------------------------------------------------------------------
Date: Thu, 10 Apr 2014 14:43:38 -0400
From: Simon Marchi <simon.marchi@polymtl.ca>

>>>>   Should be "[...] should not begin with '-' [...]" (although it is =

>>>> true the size string should not *contain*, the test is only for =

>>>> *begins with*)

> I meant for it to search in the whole string, and that is what I think st=
rchr does.

Oops, my bad.

> [...]
> +       if (num_end =3D=3D str) {
> +               /* strtoull parsed nothing, not good. */
> +               DBG("utils_parse_size_suffix: strtoull had nothing good t=
o parse.\n");
> +               ret =3D -1;
> +               goto end;
> +       }
>
>>>>   "utils_parse_size_suffix: zero-length size string." would be clearer=
.  Also note that the preceding DBG strings did not end with '\n'.

> This test indeed will catch zero-length strings. However, if you pass "he=
llo", or "k", strtoull will just parse 0 characters and return the value 0.=
 This test is for these cases as well, which are not zero-length strings. I=
 agree that it's not very clear, but I have nothing better...

How about " utils_parse_size_suffix: size string does not begin with a numb=
er."?

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
