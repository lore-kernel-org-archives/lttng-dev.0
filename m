From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Looking for documentation on the old LTTng trace
 formats, 2.3-2.6
Date: Tue, 6 Aug 2013 13:56:42 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD266610A0__45482.8887632631$1375797464$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1V6hki-0005my-D9
	for lttng-dev@lists.lttng.org; Tue, 06 Aug 2013 09:56:50 -0400
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
Cc: =?iso-8859-1?Q?David_Lindstr=F6m?= <david.lindstrom@percepio.se>, "Painchaud, Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>, "Couture, Mario" <Mario.Couture@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

----------------------------------------------------------------------
Message: 1
Date: Mon, 5 Aug 2013 14:24:34 +0200
From: "=3D?utf-8?Q?David_Lindstr=3DC3=3DB6m?=3D" <david.lindstrom@percepio.=
se>

I?m looking for documentation on the old/legacy LTTng trace formats. Before=
 LTTng 2.x and CTF that is. I found a PDF titled "LTTng Trace Binary Format
v2.3 Guidelines" which details the 2.3 format nicely. However, I need to su=
pport the later versions as well which I'm unable to find anything at all a=
bout. What changed between 2.3 and 2.6?

Does such documentation even exists? If not, what would be my best options =
to figure it out?

Mvh
David Lindstr=F6m =

------------------------------

   I had to deal with this when I wrote a RapidMiner plugin that could read=
 LTTng Trace Format 2.6 traces.  The format does not even have a name or de=
signation, so I started calling it LTF (LTTng Trace Format).  Here is the s=
chedule of "LTTng 1" (a.k.a. LTTng 0.x) trace proprietary formats (indicati=
ng lower bounds):

LTF 0.4 LTTV 0.6.9 LTTng 0.4.4
LTF 0.5      0.7.0       0.4.5
LTF 0.6      0.8.0       0.5.0
LTF 0.7      0.8.6       0.5.7
LTF 0.8      0.8.80      0.6.78
LTF 1.0      0.10.0-pre1 0.10.0-pre5
LTF 2.0      0.11.0      0.38
LTF 2.1      0.11.1      0.39
LTF 2.2      0.11.4      0.47
LTF 2.3      0.12.0      0.65
LTF 2.4      0.12.21     0.171
LTF 2.5      0.12.22     0.173
LTF 2.6      0.12.30     0.191
LTF id.      0.12.38     0.249   (last versions)

For instance, LTF 2.1 was used starting with LTTng 0.39, and was replaced b=
y LTF 2.2 with LTTng 0.47.

As you've seen, the pre-2.3 documentation is fragmentary and very poor, the=
 *only* true documentation being Philippe Proulx (2009), "LTTng Trace Binar=
y Format v2.3 Guidelines".

One key difference between formats 2.3 and 2.5 is in the block header, wher=
e the lost_size field (indicating how many bytes of padding are at the bloc=
k's end) became its complement, used_size (indicating how many bytes of the=
 block are useful).

I have not yet identified any differences of consequence between LTF 2.5 an=
d 2.6.  If you have samples of traces in specific legacy formats (pre-2.3 i=
n particular), I'd love to run my LTFReader on them and see if anything pop=
s.

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
