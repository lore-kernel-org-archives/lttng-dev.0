From: =?ISO-8859-1?Q?Marc-Andr=E9_Laperle?= <marc-andre.laperle@ericsson.com>
Subject: Re: lttng git repositories and Eclipse
Date: Wed, 30 Apr 2014 11:57:34 -0400
Message-ID: <53611D6E.2070703__48073.6631005586$1398873516$gmane$org@ericsson.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD3599E43E@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg21.ericsson.net ([198.24.6.65])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <marc-andre.laperle@ericsson.com>) id 1WfWtC-0004pa-Gk
 for lttng-dev@lists.lttng.org; Wed, 30 Apr 2014 11:57:44 -0400
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD3599E43E@VAL-E-01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Daniel,

This sounds more of a question for the CDT mailing list or forum.

On 14-04-30 11:48 AM, Thibault, Daniel wrote:
> In the first case, Project type: GNU Autotools only allows "Empty project=
" which is no good.

Try it this way it should work. Change the location to point to the your
lttng-ust folder. Basically, every .configure folder should map to a
different CDT project. "Empty project" in this case means that it just
doesn't create source files for you. "Makefile Project with Existing
Code" does pretty much the same thing as a new project with Makefile >
Empty project but there's not Autotools equivalent.

Marc-Andr=E9

On 14-04-30 11:48 AM, Thibault, Daniel wrote:
>    Using a fresh Eclipse C/C++ environment (Kepler 4.3.2), what's the bes=
t way to load the LTTng git source tree?  Cloning the git.lttng.org lttng-u=
st master branch (for example) is easy, my problem is in getting the Autoto=
ols to kick in properly.  Eclipse's array of options is somewhat overwhelmi=
ng; as a consequence I've managed to build userspace-rcu, but I didn't take=
 notes and I can't seem to reproduce the method with lttng-ust.  Frustratin=
g.
>
> File: Import...
> [Import]
> Git > Projects from Git
> (Next)
>
> [Import Projects from Git: Select Repository Source]
> Clone URI
> (Next)
>
> [Import Projects from Git: Source Git Repository]
> URI: http://git.lttng.org/lttng-ust.git
> (Host: git.lttng.org)
> (Repository Path: /lttng-ust.git)
> (Protocol: http)
> (Next)
>
> [Import Projects from Git: Branch Selection]
> (Deselect All) (master)
> (Next)
>
> [Import Projects from Git: Local Destination]
> Directory: /home/username/git/git.lttng.org/lttng-ust
> (Initial branch: master)
> Clone submodules
> (Remote name: origin)
>
> [Cloning from http://git.lttng.org/lttng-ust.git: Select a wizard to use =
for importing projects]
>
> This is where I need advice.  The three options are:
>
> Import existing projects
> Import as general project
> Use the New Project wizard
>
>    Clearly the first is not applicable since the source trees are not Ecl=
ipse projects (neither should they be).
>
>    If I "Use the New Project wizard", the two pertinent choices seem to b=
e:
>
> C/C++ > C Project
> and
> C/C++ > Makefile Project with Existing Code
>
>    In the first case, Project type: GNU Autotools only allows "Empty proj=
ect" which is no good.
>
>    In the second case, I must browse to the git clone directory.  I end u=
p with an inert project, but if I then go to its Properties: Builders, ther=
e is no way to add GNU Autotools.
>
>    If I "Import as general project", I can then invoke "File: New: Conver=
t to a C/C++ Autotools Project".  This *almost* works, with the console sho=
wing configure attempting to run and failing because bootstrap did not run =
("Invoking autoreconf in build directory: /home/daniel/git/git.lttng.org/lt=
tng-ust/  |  sh -c "autoreconf -i"  |  aclocal: couldn't open directory `co=
nfig': No such file").  I can shell out to the directory, run bootstrap, th=
en refresh the Eclipse project and pick "Reconfigure project" from the cont=
extual menu.  I can't help but hope there's an easier, better way?
>
>    Help?
>
> Daniel U. Thibault
> Protection des syst=E8mes et contremesures (PSC) | Systems Protection & C=
ountermeasures (SPC)
> Cyber s=E9curit=E9 pour les missions essentielles (CME) | Mission Critica=
l Cyber Security (MCCS)
> R & D pour la d=E9fense Canada - Valcartier (RDDC Valcartier) | Defence R=
&D Canada - Valcartier (DRDC Valcartier)
> 2459 route de la Bravoure
> Qu=E9bec QC  G3J 1X5
> CANADA
> Vox : (418) 844-4000 x4245
> Fax : (418) 844-4538
> NAC : 918V QSDJ <http://www.travelgis.com/map.asp?addr=3D918V%20QSDJ>
> Gouvernement du Canada | Government of Canada
> <http://www.valcartier.drdc-rddc.gc.ca/>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
