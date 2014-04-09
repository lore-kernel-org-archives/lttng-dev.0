From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Regarding Bug #633 - utils_parse_size_suffix
 suffers from several problems
Date: Wed, 9 Apr 2014 13:42:39 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD35996E2C__4773.587632417$1397051041$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WXsm4-0000gg-O7
 for lttng-dev@lists.lttng.org; Wed, 09 Apr 2014 09:42:50 -0400
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
Date: Tue, 8 Apr 2014 22:09:36 -0700
From: Sandeep K Chaudhary <babbusandy2006@gmail.com>
To: David Goulet <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>

> Here is the diff for changes made to the unit test. Please have a look.
----------------------------------------------------------------------

   I would suggest these additional valid and invalid test cases:

Valid:

{ "00", 0 },
{ "0k", 0 },
{ "0K", 0 },
{ "0M", 0 },
{ "0G", 0 },
{ "00k", 0 },
{ "00K", 0 },
{ "00M", 0 },
{ "00G", 0 },
{ "0x0", 0 },
{ "0X0", 0 },
{ "0x0k", 0 },
{ "0X0K", 0 },
{ "0x0M", 0 },
{ "0X0G", 0 },
{ "0x40C", 1036 },
{ "0X40D", 1037 },
{ "0X40G", 68719476736 },
{ "0300k", 196608 },
{ "0300K", 196608 },
{ "030M", 25165824 },
{ "020G", 17179869184 },
{ "0xa0k", 163840 },
{ "0xa0K", 163840 },
{ "0XA0M", 167772160 },
{ "0xA0G", 171798691840 },

Invalid:

" ", "x0", "0xx0", "07kK", "0xk", "0XM", "0xG", "0x0MM", "0X0GG", "0a", "0B"

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
