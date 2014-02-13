From: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Subject: Re: Machine Interface
Date: Thu, 13 Feb 2014 14:16:59 -0500
Message-ID: <20140213191658.GA16437__13672.0926072032$1392319092$gmane$org@gmail.com>
References: <52FD0831.7030704@polymtl.ca>
	<CAFXXi0mcn4MUA0iHE-+HGqcqrsyf=wgWXPFMnBJrc+xrF96gaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jonathan.r.julien@gmail.com>) id 1WE1mW-0002S6-61
	for lttng-dev@lists.lttng.org; Thu, 13 Feb 2014 14:17:14 -0500
Received: by mail-ig0-f172.google.com with SMTP id k19so13590730igc.5
	for <lttng-dev@lists.lttng.org>; Thu, 13 Feb 2014 11:17:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAFXXi0mcn4MUA0iHE-+HGqcqrsyf=wgWXPFMnBJrc+xrF96gaQ@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Marchi <simon.marchi@polymtl.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Thu, Feb 13, 2014 at 01:26:09PM -0500, Simon Marchi wrote:
> It looks good!
> =

> Comments below.
> =

> On 13 February 2014 13:00, Olivier Cotte <olivier.cotte@polymtl.ca> wrote:
> > At first, we wanted thank you for your quick and constructive feedback!
> >
> > After reflection on the nature of the problem and consideration of your
> > feedback, we've arrived with the following solution.
> >
> > The technology that will be use is XML. The integration of the machine
> > interface to LTTng will be done in the most modular manner to facilitat=
e the
> > support multiples outputs format. This option will most likely be avail=
able
> > at configure time.
> >
> > For the moment, we will focus our effort into adding the XML feature on=
ly.
> > If many outputs languages is still a viable feature, it will be possibl=
e to
> > investigate.
> >
> > Our main goal is of course to promote extensibility, ease of developmen=
t for
> > new tools and establish a standards for the communication control flow.=
 Here
> > are our primary requirement concerning the machine interface:
> >
> >   * Fit the tree structure of LTTng commands structures.
> >   * It can be parse from bash/shell script with no external helpers.
> >   * The new format must not introduce any dependencies to LTTng.
> >   * [Optional] Still human readable, but fit to be parse.This is not a
> >      priority since we are talking about a machine interface.
> >
> > Here are the reason why we think XML should be used for the machine
> > interface:
> >
> >   * The expression of LTTng hierarchy really fit a XML tree structure.
> >   * Since Jgalar add a load-save feature that depend on libxml2, we are
> >     not introducing any dependencies. Choosing another format would
> >     most likely introduce new dependency.
> >   * XML is robust and easily extensible. It will also be easy to
> >     maintains (add new commands, modify existing commands etc.)
> >   * There are tools that allow you to evaluate XPath expressions from
> >     the bash.
> =

> In the requirements above, you said "It can be parse from bash/shell
> script with no external helpers". For XML it's not really the case. I
> don't really mind (I am fine withXML), but I just think those are
> contradictory statements.
True, but the requirement are 'ideal objectives'. The choice of XML do not =
complies with
this requirement but fits most of the requirements. I think we
misspoke on this.
> =

> >   * XML is an established standard
> >
> > That's why we consider XML format as a suitable solution.
> >
> > Now for the machine interface syntax:
> >
> >   * Since we are aware that multiple output could be supported, we want=
 an
> >     unify flag for all machine interface command.
> > The flag --xml would be used to output xml from LTTng (we could add
> > similar
> > options like --json, --yaml etc.). This would be similar to svn
> > machine interface and speak for itself.
> >   * Also, to avoid confusion we will use a different primary command for
> > input and
> >     output machine interface.
> > Ex: lttng machine <input>
> > Ex: lttng --xml <output>
> =

> Can you give an (preliminary) example usage of lttng machine ? The XML
> document would be a big string / a single argument ?
> =

We are not sure yet... but probably a big string(one-lined XML).
Could be a file but i don't see any advantage.

Another option would be a prompt.. like GDB Machine Interface.
> Also, could lttng machine also be able to read its input from stdin?
> If it does, could it receive multiple commands in a single invocation?
> For example, each root-level XML element could represent a command.
> This way, a program would have to do a single exec and then push all
> the commands one by one to the lttng client.
> =

That was the plan.

To be frank, we will mostly put effort in the output side of MI.If
everything is *functional* and *approved* we will work on input.

> I have not really thought this through, I am just putting the idea in the=
 wild.
> =

> > Any points we are missing?
> =

> I don't know how it would look, but as a user/developer, it would be
> nice if there was a way for lttng to dump me the XML that corresponds
> to a command (e.g. what I need to feed lttng machine to have the same
> effect as a command).
> =

> Example with syntax I just made up:
> =

> lttng --dump-xml-input enable-event -k sched_switch,other_event
> =

> would output
> =

> <lttng>
>     <command name=3D"enable-event" domain=3D"kernel">
>         <event name=3D"sched_switch"/>
>         <event name=3D"other_event"/>
>     </command>
> </lttng>
> =

nice idea

> I feel that this feature would make the machine interface more
> approachable (less doc to read before you start being efficient). What
> do you think?
> =

> Simon
> =

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- =

Jonathan Rajotte Julien
Charg=E9 de laboratoire INF1995
Membre MD6
Polytechnique Montr=E9al
