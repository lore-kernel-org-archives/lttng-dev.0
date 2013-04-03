From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: [PATCH lttng-tools] lttng cli: Accept human
 readable sizes for --subbuf-size
Date: Wed, 3 Apr 2013 19:36:21 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD12D04580__2738.79480450905$1365017907$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1UNTUu-0002zu-FF
	for lttng-dev@lists.lttng.org; Wed, 03 Apr 2013 15:37:28 -0400
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
Cc: "Painchaud, Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>, "Couture,
	Mario" <Mario.Couture@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

>>> --subbuf-size accepts sizes such as:
>>>
>>> - 123 -> 123
>>> - 123k or 123K -> 123 * 1024
>>> - 123m or 123M -> 123 * 1024 * 1024
>>> - 123g or 123G -> 123 * 1024 * 1024 * 1024
>>
>> I don't really like using non-SI prefixes such as "K", "m" or "g" =

>> (well, in fact "m" is an SI prefix but for milli, not mega).
>> I think that would be better to only use "k", "M" and "G".
>
>Agreed. I'll do that.
>Simon

   Normally I'd be the first to advocate k, M, G as powers of 10 and Ki, Mi=
, Gi as powers of two (ISO/IEC 80000-13:2008) but the kernel parameters use=
 exclusively K, M, and G in the powers of two sense, and I believe just abo=
ut every other part of Linux does also.  We should thus, somewhat unfortuna=
tely, stick to powers of two.  Just be sure to explicitly give the multipli=
ers' values in the help.  Oh, and accept just the upper-case letters, like =
the kernel parameters do.

Daniel U. Thibault
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) / Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
Cyber s=E9curit=E9 pour les missions essentielles (CME) / Mission Critical =
Cyber Security (MCCS)
Protection des syst=E8mes et contremesures (PSC) / Systems Protection & Cou=
ntermeasures (SPC)
2459 route de la Bravoure
Qu=E9bec, QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada / Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
