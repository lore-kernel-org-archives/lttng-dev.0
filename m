From: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Subject: Re: Machine Interface
Date: Thu, 6 Feb 2014 12:00:39 -0500
Message-ID: <20140206170038.GA30540__2374.02996649525$1391706117$gmane$org@gmail.com>
References: <20140206024218.GD23121@gmail.com>
	<CAGDH53mHYJg-uVd+4Cv=X6ST5Ly+nmE_BQSVmdN3Hb4k7ZKeSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jonathan.r.julien@gmail.com>) id 1WBSJq-0005yU-5f
	for lttng-dev@lists.lttng.org; Thu, 06 Feb 2014 12:00:59 -0500
Received: by mail-qc0-f182.google.com with SMTP id c9so3574859qcz.41
	for <lttng-dev@lists.lttng.org>; Thu, 06 Feb 2014 09:00:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGDH53mHYJg-uVd+4Cv=X6ST5Ly+nmE_BQSVmdN3Hb4k7ZKeSw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Thu, Feb 06, 2014 at 11:11:39AM -0500, Christian Babeux wrote:
> Hi Jonathan,
> =

> > Multiples solutions come to mind:
> > -XML
> > -JSON
> > -YAML
> > -Custom syntax (like GDB Machine interface* as proposed by Alexandre
> >                                 Montplaisir)
> =

> I would advocate for the use of XML for the machine interface. Two
> reasons come to mind:
> =

> 1 - The expression of hierarchy (session, events, etc.) is much easier wi=
th XML.
> =

> 2 - In a recent post [1], it was decided that the configuration load
> and restore (for sessions) would also use XML. This will introduce a
> new dependency on libxml. If we were to choose yet another format for
> the machine interface, we would probably need to introduce another
> dependency to some library.

Good point
+1 for XML

> =

> > Machine interface output would be generated only with --mi option and
> > could contain additional information than regular output.
> =

> Perhaps adding --xml option to the relevant command? This would be
> similar to svn machine interface [2].

How about --machine-interface <output-type>?
By default <output-type> would be the chosen format.

This open opportunities for other MI type and have an unified syntax.

--xml option is clear and efficient.We could
add an option for each type (--json,--yaml) if needed.

> =

> Thanks,
> =

> Christian
> =

> [1] - http://lists.lttng.org/pipermail/lttng-dev/2013-December/022068.html
> [2] - http://svnbook.red-bean.com/en/1.7/svn-book.html#svn.ref.svn.sw
> =

> On Wed, Feb 5, 2014 at 9:42 PM, Jonathan Rajotte
> <jonathan.r.julien@gmail.com> wrote:
> > Hello all,
> >
> > After speaking with Michel Dagenais, Genevi=E8ve Bastien, folks over at=
 EfficiOs
> > and Ericsson, a machine interface for lttng-tool would be a nice feature
> > to have. Olivier Cotte and me will be working on MI for the
> > next few weeks.
> >
> > The main objective would be to reduce parsing complexity
> > in control tools.
> > ex:Regex used in TMF control service.
> > (org.eclipse.linuxtools.internal.lttng2.ui.views.control.service.LTTngC=
ontrolService.java)
> >
> > Multiples solutions come to mind:
> > -XML
> > -JSON
> > -YAML
> > -Custom syntax (like GDB Machine interface* as proposed by Alexandre
> >                                 Montplaisir)
> >
> > XML/JSON/YAML promote extensibility and ease of development for new too=
ls
> > dependant on lttng-tools by being established standards.
> > On the other hand, they add dependencies to lttng-tools where a custom =
syntax
> > would not.
> >
> > Machine interface output would be generated only with --mi option and
> > could contain additional information than regular output.
> >
> > We are focusing on output right now but we may eventually add a 'mi'
> > command for input if necessary.
> >
> > What do you think ?
> >
> > Thanks
> >
> >
> > *https://sourceware.org/gdb/onlinedocs/gdb/GDB_002fMI.html
> >
> > --
> > Jonathan Rajotte Julien
> > Charg=E9 de laboratoire INF1995
> > Membre MD6
> > Polytechnique Montr=E9al
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Jonathan Rajotte Juliana
Charg=E9 de laboratoire INF1995
Membre MD6
Polytechnique Montr=E9al
