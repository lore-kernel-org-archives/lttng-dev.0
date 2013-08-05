From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Release strategy
Date: Mon, 5 Aug 2013 09:33:26 -0400
Message-ID: <20130805133326.GC12410__31003.0191591524$1375709657$gmane$org@Krystal>
References: <51EEDF15.4090300@ericsson.com>
	<CAGDH53=w6Wgat9vpL+iWd4mBfyM9CQuxGJEkN4095AeBB-LWog@mail.gmail.com>
	<CA+jJMxsPH9s=OBEcD4+_92aoiDw6_EdePTZJMA9VtLPSrVzh_w@mail.gmail.com>
	<CAGDH53mLbWjzfokb8F80=4w5YTHPAP5XsfT8N0o8CSP38jQerg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1V6Kue-00011K-Uz
	for lttng-dev@lists.lttng.org; Mon, 05 Aug 2013 09:33:32 -0400
Content-Disposition: inline
In-Reply-To: <CAGDH53mLbWjzfokb8F80=4w5YTHPAP5XsfT8N0o8CSP38jQerg@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Christian Babeux <christian.babeux@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Etienne Bergeron <etienne.bergeron@gmail.com>
List-Id: lttng-dev@lists.lttng.org

* Christian Babeux (christian.babeux@efficios.com) wrote:
> So far multiple suggestions have been proposed for the issues outlined:
> =

> 1) Branching policy
> =

> 1. Creating a branch to stabilize new features (for release
> candidates) while development continues in master.
> 2. Staging branch for new features.
> =

> I think we will need to wait for feedback from David and Mathieu since
> they are the maintainers of the LTTng codebases. Personally, solution
> 1. get my vote.
> =

> Mathieu & David: What branching policy would you like to adopt?

I would add a 3rd option:

3. Feature freeze during rc

For two reasons:

a) It forces people to test, and pushes back on introduction of new
   code, thus improves quality,
b) keeps maintainers sane. We already have one -rc branch to manage,
   and at least one stable branch, per project (we'll have to decide how
   many stable branches we want to keep active). Adding features into
   master or a staging branch would add a 3rd branch to maintain for
   each project.

I know the downside is that contributors may have to wait before seeing
their features merged. As a side-effect, it forces them to do more
testing than writing new actual code, but this is exactly what we are
doing right now as maintainers.

> =

> 2) Release roadmap & 3) Tentative release dates
> =

> A cleanup of the bug tracker and setting clear releases dates on
> features would most likely solve this issue. Perhaps we should
> schedule a bug tracker cleaning event in August?

Sounds good.

> =

> As for the monthly summary, I volunteer to write and maintain it if
> the community is interested.

Good idea.

> =

> Also, I really like the idea proposed by Matthew for a system like
> Gerrit to handle patches submission and review. The integration with
> our Jenkins CI would be IMO quite useful to reduce time spent
> reviewing non-working or build breaking patches.
> =

> Mathieu & David: Would you be open to use such a system for patches?

Yes. We should compare this system with others used e.g. at Google.
Etienne Bergeron has interesting feedback on this topic.

Thanks,

Mathieu

> =

> Thanks,
> =

> Christian
> =

> On Wed, Jul 24, 2013 at 10:36 AM, J=E9r=E9mie Galarneau
> <jeremie.galarneau@efficios.com> wrote:
> > On Tue, Jul 23, 2013 at 11:30 PM, Christian Babeux
> > <christian.babeux@efficios.com> wrote:
> >> Hi Matthew,
> >>
> >> You certainly raise valid and interesting questions about our release
> >> process. Here how I would categorize these questions:
> >>
> >> 1) Branching policy (when do we branch master? after the first release
> >> candidate or after a final release?)
> >>
> >> 2) Release roadmap (when the next release is planned? what does it con=
tain?)
> >>
> >> 3) Tentative release dates
> >>
> >> For 1), the current way we are doing things is that during a release
> >> candidate phase for a new stable release, a complete code freeze is in
> >> effect e.g. only bug fixes will be merged until a stable release is
> >> out. Normally, after multiple release candidates, master is branched
> >> into a stable branch and the final official stable release is created
> >> from that branch.
> >>
> >> This could potentially cause troubles for contributors, e.g. posting a
> >> set of patches and getting no response or waiting for merge if a
> >> release candidate cycle is in effect. Any ideas/suggestions on how we
> >> could improve this?
> >>
> >
> > We should create a separate branch at the first release candidate and
> > stabilize it until the official release. The feature freeze would then
> > only apply to that branch while invasive changes could be merged in
> > master at all times. It would certainly make it easier on occasional
> > contributors that may not be aware of the release schedule (at the
> > expense of the maintainers' sanity...).
> >
> >> For 2), the release roadmap is available at [1]. The roadmap is kind
> >> of a mess right now because bugs are assigned to older stable releases
> >> giving the wrong impression that some stable releases are way late.
> >>
> >> We would need a way to distinguish between bugs on already released
> >> versions and features targeting future versions. Perhaps something
> >> like [2-3] could be promising?
> >>
> >
> > Disciplining ourselves in opening Features with reasonable target
> > dates on the bug tracker may be enough to make the current "Roadmap"
> > plug-in useful.
> >
> >> For 3), I would try to put tentative release dates on the roadmap on
> >> Redmine or on a wiki article similar to [4]?
> >>
> >
> > I'd prefer using the roadmap functionality. I'm afraid the wiki won't
> > be maintained as releases slip.
> >
> >> Another point that you did not mention is how we plan minor releases.
> >> I think we will need to define a clear policy for minor releases
> >> sooner than later because it is becoming quite painful to support
> >> three codebases (modules, ust, tools) with three stable branches...
> >> Perhaps in another thread?
> >>
> >> On a more general note, I think clear communication is the key here.
> >> I'm wondering if a monthly summary of the development activities on
> >> LTTng and related projects could be interesting for the community?
> >> Content example:
> >>
> >> - What have we accomplished in the past month.
> >> - What we are planning for the following month.
> >> - Release status (next stable tentative release dates, planned minor
> >> releases, etc.)
> >> - Etc.
> >>
> >
> > Sounds good. It would also be a great opportunity to structure
> > discussions around the planning.
> >
> > Regards,
> > J=E9r=E9mie
> >
> >> Any ideas/suggestions/constructive criticism on how we can improve our
> >> release process are quite welcome!
> >>
> >> Thanks,
> >>
> >> Christian
> >>
> >> [1] - http://bugs.lttng.org/projects/lttng/roadmap
> >> [2] - http://www.redmine.org/plugins/advanced_roadmap
> >> [3] - http://www.redmine.org/plugins/redmine_milestones
> >> [4] - https://www.gnu.org/software/gdb/schedule/
> >>
> >> On Tue, Jul 23, 2013 at 3:52 PM, Matthew Khouzam
> >> <matthew.khouzam@ericsson.com> wrote:
> >>> Hello tracing rangers,
> >>>
> >>> I am a bit confused about the whole release cycle system.
> >>>
> >>> If you guys are in RC, I have a cool feature I was working on, where =
do
> >>> I put it?
> >>>
> >>> When are releases coming out? is it planned or a surprise (I know it's
> >>> planned)
> >>>
> >>> What are your hard / soft deadlines?
> >>>
> >>> Thanks,
> >>> Matthew
> >>>
> >>> _______________________________________________
> >>> lttng-dev mailing list
> >>> lttng-dev@lists.lttng.org
> >>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >>
> >> _______________________________________________
> >> lttng-dev mailing list
> >> lttng-dev@lists.lttng.org
> >> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
> >
> >
> > --
> > J=E9r=E9mie Galarneau
> > EfficiOS Inc.
> > http://www.efficios.com

-- =

Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
