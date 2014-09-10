From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: Odd file and path in lttng-tools tarball
Date: Wed, 10 Sep 2014 20:28:48 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD4EC62BA3__42263.7842399583$1410380994$gmane$org@VAL-E-02.valcartier.drdc-rddc.gc.ca>
References: <48CF5AC71E61DB46B70D0F388054EFFD4EC61B86@VAL-E-02.valcartier.drdc-rddc.gc.ca>
 <20140910202418.GQ8256@thessa>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1XRoVb-0008UI-Kk
 for lttng-dev@lists.lttng.org; Wed, 10 Sep 2014 16:29:01 -0400
In-Reply-To: <20140910202418.GQ8256@thessa>
Content-Language: fr-FR
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

-----Message d'origine-----
De=A0: David Goulet [mailto:dgoulet@efficios.com] =

Envoy=E9=A0: 10 septembre 2014 16:24

> > tests/regression/tools/save-load/ =

> > /tmp/tmp.eAJ1f0oCZE/test-42/save-42.lttng
>
> Hrm ... I don't see that in any 2.5.0-rcX tarball...
>
> Maybe it was created on your side? Is the tarball matching the gpg signat=
ure also once downloaded?
>
> David

   Nope, not a local artefact.  You can see it in the gitweb interface ever=
ywhere.  Starting at for instance http://git.lttng.org/?p=3Dlttng-tools.git=
;a=3Dtree;f=3Dtests/regression/tools/save-load;h=3Db792f337a7d13cf17b519b02=
de88db4d73b215f6;hb=3D883d80f9e038060bccf0512679eb366c7b245d14 you can spot=
 the ' ' folder deep inside of which lies the save-42.lttng

   (Just in case the URL gets mangled by e-mail filters, here it is in bits=
:)
http://
git.lttng.org/
?p=3Dlttng-tools.git;
a=3Dtree;
f=3Dtests/regression/tools/save-load;
h=3Db792f337a7d13cf17b519b02de88db4d73b215f6;
hb=3D883d80f9e038060bccf0512679eb366c7b245d14

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
RDDC - Centre de recherches de Valcartier | DRDC - Valcartier Research Cent=
re
2459 route de la Bravoure
Qu=E9bec QC  G3J 1X5
CANADA
Vox : (418) 844-4000 x4245
Fax : (418) 844-4538
NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada | Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
