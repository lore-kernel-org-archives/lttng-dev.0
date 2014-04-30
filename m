From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: Re: lttng git repositories and Eclipse
Date: Wed, 30 Apr 2014 16:29:55 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD3599E475__44769.8241136552$1398875491$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WfXOZ-00053Q-1n
 for lttng-dev@lists.lttng.org; Wed, 30 Apr 2014 12:30:12 -0400
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

Date: Wed, 30 Apr 2014 11:57:34 -0400
From: Marc-Andr=E9 Laperle <marc-andre.laperle@ericsson.com>

> On 14-04-30 11:48 AM, Thibault, Daniel wrote:
> > File: Import...
> > [Import]
> > Git > Projects from Git
> > (Next)
> > [...]
> > [Cloning from http://git.lttng.org/lttng-ust.git: Select a wizard to us=
e for importing projects]
> > Use the New Project wizard
> >
> > C/C++ > C Project
> >
> >   Project type: GNU Autotools only allows "Empty project" which is no g=
ood.
> >    [...]
>
> Try it this way it should work. Change the location to point to your lttn=
g-ust folder. Basically, every .configure folder should map to a
> different CDT project. "Empty project" in this case means that it just do=
esn't create source files for you. "Makefile Project with Existing
> Code" does pretty much the same thing as a new project with Makefile > Em=
pty project but there's no Autotools equivalent.
>
> Marc-Andr=E9

   Thanks, that works!

   What's odd is that the console, in this case, shows it starts the config=
uration with 'sh -c "autoreconf -i"', just like it did when I converted the=
 imported general project to a C/C++ Autotools Project.  Why does it succee=
d in running bootstrap when the other fails?

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
