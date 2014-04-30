From: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Subject: lttng git repositories and Eclipse
Date: Wed, 30 Apr 2014 15:48:07 +0000
Message-ID: <48CF5AC71E61DB46B70D0F388054EFFD3599E43E__37260.6697529138$1398872973$gmane$org@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fw.drenet.dnd.ca ([131.136.242.1] helo=mx.drdc-rddc.gc.ca)
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Daniel.Thibault@drdc-rddc.gc.ca>) id 1WfWk1-0004lX-QX
 for lttng-dev@lists.lttng.org; Wed, 30 Apr 2014 11:48:19 -0400
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

   Using a fresh Eclipse C/C++ environment (Kepler 4.3.2), what's the best =
way to load the LTTng git source tree?  Cloning the git.lttng.org lttng-ust=
 master branch (for example) is easy, my problem is in getting the Autotool=
s to kick in properly.  Eclipse's array of options is somewhat overwhelming=
; as a consequence I've managed to build userspace-rcu, but I didn't take n=
otes and I can't seem to reproduce the method with lttng-ust.  Frustrating.

File: Import...
[Import]
Git > Projects from Git
(Next)

[Import Projects from Git: Select Repository Source]
Clone URI
(Next)

[Import Projects from Git: Source Git Repository]
URI: http://git.lttng.org/lttng-ust.git
(Host: git.lttng.org)
(Repository Path: /lttng-ust.git)
(Protocol: http)
(Next)

[Import Projects from Git: Branch Selection]
(Deselect All) (master)
(Next)

[Import Projects from Git: Local Destination]
Directory: /home/username/git/git.lttng.org/lttng-ust
(Initial branch: master)
Clone submodules
(Remote name: origin)

[Cloning from http://git.lttng.org/lttng-ust.git: Select a wizard to use fo=
r importing projects]

This is where I need advice.  The three options are:

Import existing projects
Import as general project
Use the New Project wizard

   Clearly the first is not applicable since the source trees are not Eclip=
se projects (neither should they be).

   If I "Use the New Project wizard", the two pertinent choices seem to be:

C/C++ > C Project
and
C/C++ > Makefile Project with Existing Code

   In the first case, Project type: GNU Autotools only allows "Empty projec=
t" which is no good.

   In the second case, I must browse to the git clone directory.  I end up =
with an inert project, but if I then go to its Properties: Builders, there =
is no way to add GNU Autotools.

   If I "Import as general project", I can then invoke "File: New: Convert =
to a C/C++ Autotools Project".  This *almost* works, with the console showi=
ng configure attempting to run and failing because bootstrap did not run ("=
Invoking autoreconf in build directory: /home/daniel/git/git.lttng.org/lttn=
g-ust/  |  sh -c "autoreconf -i"  |  aclocal: couldn't open directory `conf=
ig': No such file").  I can shell out to the directory, run bootstrap, then=
 refresh the Eclipse project and pick "Reconfigure project" from the contex=
tual menu.  I can't help but hope there's an easier, better way?

   Help?

Daniel U. Thibault
Protection des syst=E8mes et contremesures (PSC) | Systems Protection & Cou=
ntermeasures (SPC)
Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critical =
Cyber Security (MCCS)
R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R&D=
 Canada - Valcartier (DRDC Valcartier)
2459 route de la Bravoure
Qu=E9bec QC=A0 G3J 1X5
CANADA
Vox=A0: (418) 844-4000 x4245
Fax=A0: (418) 844-4538
NAC=A0: 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
Gouvernement du Canada=A0| Government of Canada
<http://www.valcartier.drdc-rddc.gc.ca/>
