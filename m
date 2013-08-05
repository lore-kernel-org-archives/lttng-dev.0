From: Etienne Bergeron <etienne.bergeron@gmail.com>
Subject: Re: Release strategy
Date: Mon, 5 Aug 2013 09:46:02 -0400
Message-ID: <CAAdodk9qFR6PecQwZrza3B_PF+9_r4SDyFdre=i2yTO5LJe_mQ__26377.7459542782$1375710539$gmane$org@mail.gmail.com>
References: <51EEDF15.4090300@ericsson.com>
	<CAGDH53=w6Wgat9vpL+iWd4mBfyM9CQuxGJEkN4095AeBB-LWog@mail.gmail.com>
	<CA+jJMxsPH9s=OBEcD4+_92aoiDw6_EdePTZJMA9VtLPSrVzh_w@mail.gmail.com>
	<CAGDH53mLbWjzfokb8F80=4w5YTHPAP5XsfT8N0o8CSP38jQerg@mail.gmail.com>
	<20130805133326.GC12410@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0795471089=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ve0-f178.google.com ([209.85.128.178])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <etienne.bergeron@gmail.com>) id 1V6L6u-0001SY-95
	for lttng-dev@lists.lttng.org; Mon, 05 Aug 2013 09:46:13 -0400
Received: by mail-ve0-f178.google.com with SMTP id ox1so3120724veb.9
	for <lttng-dev@lists.lttng.org>; Mon, 05 Aug 2013 06:46:02 -0700 (PDT)
In-Reply-To: <20130805133326.GC12410@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0795471089==
Content-Type: multipart/alternative; boundary=047d7bd6bf827bc9e604e333878d

--047d7bd6bf827bc9e604e333878d
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

In our team, we use appspot.com. The website manages any "diff" (svn diff,
git diff, etc...).
And anybody can send a code review on any project. It's a open code review
plateform.
So, there is not a lot of feature but it is integrated in our tools.

I never try guerrit, but probably the same kind of feature.


On Mon, Aug 5, 2013 at 9:33 AM, Mathieu Desnoyers <
mathieu.desnoyers@efficios.com> wrote:

> * Christian Babeux (christian.babeux@efficios.com) wrote:
> > So far multiple suggestions have been proposed for the issues outlined:
> >
> > 1) Branching policy
> >
> > 1. Creating a branch to stabilize new features (for release
> > candidates) while development continues in master.
> > 2. Staging branch for new features.
> >
> > I think we will need to wait for feedback from David and Mathieu since
> > they are the maintainers of the LTTng codebases. Personally, solution
> > 1. get my vote.
> >
> > Mathieu & David: What branching policy would you like to adopt?
>
> I would add a 3rd option:
>
> 3. Feature freeze during rc
>
> For two reasons:
>
> a) It forces people to test, and pushes back on introduction of new
>    code, thus improves quality,
> b) keeps maintainers sane. We already have one -rc branch to manage,
>    and at least one stable branch, per project (we'll have to decide how
>    many stable branches we want to keep active). Adding features into
>    master or a staging branch would add a 3rd branch to maintain for
>    each project.
>
> I know the downside is that contributors may have to wait before seeing
> their features merged. As a side-effect, it forces them to do more
> testing than writing new actual code, but this is exactly what we are
> doing right now as maintainers.
>
> >
> > 2) Release roadmap & 3) Tentative release dates
> >
> > A cleanup of the bug tracker and setting clear releases dates on
> > features would most likely solve this issue. Perhaps we should
> > schedule a bug tracker cleaning event in August?
>
> Sounds good.
>
> >
> > As for the monthly summary, I volunteer to write and maintain it if
> > the community is interested.
>
> Good idea.
>
> >
> > Also, I really like the idea proposed by Matthew for a system like
> > Gerrit to handle patches submission and review. The integration with
> > our Jenkins CI would be IMO quite useful to reduce time spent
> > reviewing non-working or build breaking patches.
> >
> > Mathieu & David: Would you be open to use such a system for patches?
>
> Yes. We should compare this system with others used e.g. at Google.
> Etienne Bergeron has interesting feedback on this topic.
>
> Thanks,
>
> Mathieu
>
> >
> > Thanks,
> >
> > Christian
> >
> > On Wed, Jul 24, 2013 at 10:36 AM, J=E9r=E9mie Galarneau
> > <jeremie.galarneau@efficios.com> wrote:
> > > On Tue, Jul 23, 2013 at 11:30 PM, Christian Babeux
> > > <christian.babeux@efficios.com> wrote:
> > >> Hi Matthew,
> > >>
> > >> You certainly raise valid and interesting questions about our releas=
e
> > >> process. Here how I would categorize these questions:
> > >>
> > >> 1) Branching policy (when do we branch master? after the first relea=
se
> > >> candidate or after a final release?)
> > >>
> > >> 2) Release roadmap (when the next release is planned? what does it
> contain?)
> > >>
> > >> 3) Tentative release dates
> > >>
> > >> For 1), the current way we are doing things is that during a release
> > >> candidate phase for a new stable release, a complete code freeze is =
in
> > >> effect e.g. only bug fixes will be merged until a stable release is
> > >> out. Normally, after multiple release candidates, master is branched
> > >> into a stable branch and the final official stable release is create=
d
> > >> from that branch.
> > >>
> > >> This could potentially cause troubles for contributors, e.g. posting=
 a
> > >> set of patches and getting no response or waiting for merge if a
> > >> release candidate cycle is in effect. Any ideas/suggestions on how w=
e
> > >> could improve this?
> > >>
> > >
> > > We should create a separate branch at the first release candidate and
> > > stabilize it until the official release. The feature freeze would the=
n
> > > only apply to that branch while invasive changes could be merged in
> > > master at all times. It would certainly make it easier on occasional
> > > contributors that may not be aware of the release schedule (at the
> > > expense of the maintainers' sanity...).
> > >
> > >> For 2), the release roadmap is available at [1]. The roadmap is kind
> > >> of a mess right now because bugs are assigned to older stable releas=
es
> > >> giving the wrong impression that some stable releases are way late.
> > >>
> > >> We would need a way to distinguish between bugs on already released
> > >> versions and features targeting future versions. Perhaps something
> > >> like [2-3] could be promising?
> > >>
> > >
> > > Disciplining ourselves in opening Features with reasonable target
> > > dates on the bug tracker may be enough to make the current "Roadmap"
> > > plug-in useful.
> > >
> > >> For 3), I would try to put tentative release dates on the roadmap on
> > >> Redmine or on a wiki article similar to [4]?
> > >>
> > >
> > > I'd prefer using the roadmap functionality. I'm afraid the wiki won't
> > > be maintained as releases slip.
> > >
> > >> Another point that you did not mention is how we plan minor releases=
.
> > >> I think we will need to define a clear policy for minor releases
> > >> sooner than later because it is becoming quite painful to support
> > >> three codebases (modules, ust, tools) with three stable branches...
> > >> Perhaps in another thread?
> > >>
> > >> On a more general note, I think clear communication is the key here.
> > >> I'm wondering if a monthly summary of the development activities on
> > >> LTTng and related projects could be interesting for the community?
> > >> Content example:
> > >>
> > >> - What have we accomplished in the past month.
> > >> - What we are planning for the following month.
> > >> - Release status (next stable tentative release dates, planned minor
> > >> releases, etc.)
> > >> - Etc.
> > >>
> > >
> > > Sounds good. It would also be a great opportunity to structure
> > > discussions around the planning.
> > >
> > > Regards,
> > > J=E9r=E9mie
> > >
> > >> Any ideas/suggestions/constructive criticism on how we can improve o=
ur
> > >> release process are quite welcome!
> > >>
> > >> Thanks,
> > >>
> > >> Christian
> > >>
> > >> [1] - http://bugs.lttng.org/projects/lttng/roadmap
> > >> [2] - http://www.redmine.org/plugins/advanced_roadmap
> > >> [3] - http://www.redmine.org/plugins/redmine_milestones
> > >> [4] - https://www.gnu.org/software/gdb/schedule/
> > >>
> > >> On Tue, Jul 23, 2013 at 3:52 PM, Matthew Khouzam
> > >> <matthew.khouzam@ericsson.com> wrote:
> > >>> Hello tracing rangers,
> > >>>
> > >>> I am a bit confused about the whole release cycle system.
> > >>>
> > >>> If you guys are in RC, I have a cool feature I was working on, wher=
e
> do
> > >>> I put it?
> > >>>
> > >>> When are releases coming out? is it planned or a surprise (I know
> it's
> > >>> planned)
> > >>>
> > >>> What are your hard / soft deadlines?
> > >>>
> > >>> Thanks,
> > >>> Matthew
> > >>>
> > >>> _______________________________________________
> > >>> lttng-dev mailing list
> > >>> lttng-dev@lists.lttng.org
> > >>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > >>
> > >> _______________________________________________
> > >> lttng-dev mailing list
> > >> lttng-dev@lists.lttng.org
> > >> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > >
> > >
> > >
> > > --
> > > J=E9r=E9mie Galarneau
> > > EfficiOS Inc.
> > > http://www.efficios.com
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--047d7bd6bf827bc9e604e333878d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">In our team, we use=A0<a href=3D"http://appspot.com">appsp=
ot.com</a>. The website manages any &quot;diff&quot; (svn diff, git diff, e=
tc...).<div>And anybody can send a code review on any project. It&#39;s a o=
pen code review plateform.</div>
<div>So, there is not a lot of feature but it is integrated in our tools.</=
div><div><br></div><div>I never try guerrit, but probably the same kind of =
feature.</div></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_=
quote">
On Mon, Aug 5, 2013 at 9:33 AM, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a =
href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.de=
snoyers@efficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">
* Christian Babeux (<a href=3D"mailto:christian.babeux@efficios.com">christ=
ian.babeux@efficios.com</a>) wrote:<br>
&gt; So far multiple suggestions have been proposed for the issues outlined=
:<br>
&gt;<br>
&gt; 1) Branching policy<br>
&gt;<br>
&gt; 1. Creating a branch to stabilize new features (for release<br>
&gt; candidates) while development continues in master.<br>
&gt; 2. Staging branch for new features.<br>
&gt;<br>
&gt; I think we will need to wait for feedback from David and Mathieu since=
<br>
&gt; they are the maintainers of the LTTng codebases. Personally, solution<=
br>
&gt; 1. get my vote.<br>
&gt;<br>
&gt; Mathieu &amp; David: What branching policy would you like to adopt?<br=
>
<br>
I would add a 3rd option:<br>
<br>
3. Feature freeze during rc<br>
<br>
For two reasons:<br>
<br>
a) It forces people to test, and pushes back on introduction of new<br>
=A0 =A0code, thus improves quality,<br>
b) keeps maintainers sane. We already have one -rc branch to manage,<br>
=A0 =A0and at least one stable branch, per project (we&#39;ll have to decid=
e how<br>
=A0 =A0many stable branches we want to keep active). Adding features into<b=
r>
=A0 =A0master or a staging branch would add a 3rd branch to maintain for<br=
>
=A0 =A0each project.<br>
<br>
I know the downside is that contributors may have to wait before seeing<br>
their features merged. As a side-effect, it forces them to do more<br>
testing than writing new actual code, but this is exactly what we are<br>
doing right now as maintainers.<br>
<br>
&gt;<br>
&gt; 2) Release roadmap &amp; 3) Tentative release dates<br>
&gt;<br>
&gt; A cleanup of the bug tracker and setting clear releases dates on<br>
&gt; features would most likely solve this issue. Perhaps we should<br>
&gt; schedule a bug tracker cleaning event in August?<br>
<br>
Sounds good.<br>
<br>
&gt;<br>
&gt; As for the monthly summary, I volunteer to write and maintain it if<br=
>
&gt; the community is interested.<br>
<br>
Good idea.<br>
<br>
&gt;<br>
&gt; Also, I really like the idea proposed by Matthew for a system like<br>
&gt; Gerrit to handle patches submission and review. The integration with<b=
r>
&gt; our Jenkins CI would be IMO quite useful to reduce time spent<br>
&gt; reviewing non-working or build breaking patches.<br>
&gt;<br>
&gt; Mathieu &amp; David: Would you be open to use such a system for patche=
s?<br>
<br>
Yes. We should compare this system with others used e.g. at Google.<br>
Etienne Bergeron has interesting feedback on this topic.<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<br>
&gt;<br>
&gt; Thanks,<br>
&gt;<br>
&gt; Christian<br>
&gt;<br>
&gt; On Wed, Jul 24, 2013 at 10:36 AM, J=E9r=E9mie Galarneau<br>
&gt; &lt;<a href=3D"mailto:jeremie.galarneau@efficios.com">jeremie.galarnea=
u@efficios.com</a>&gt; wrote:<br>
&gt; &gt; On Tue, Jul 23, 2013 at 11:30 PM, Christian Babeux<br>
&gt; &gt; &lt;<a href=3D"mailto:christian.babeux@efficios.com">christian.ba=
beux@efficios.com</a>&gt; wrote:<br>
&gt; &gt;&gt; Hi Matthew,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; You certainly raise valid and interesting questions about our=
 release<br>
&gt; &gt;&gt; process. Here how I would categorize these questions:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; 1) Branching policy (when do we branch master? after the firs=
t release<br>
&gt; &gt;&gt; candidate or after a final release?)<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; 2) Release roadmap (when the next release is planned? what do=
es it contain?)<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; 3) Tentative release dates<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; For 1), the current way we are doing things is that during a =
release<br>
&gt; &gt;&gt; candidate phase for a new stable release, a complete code fre=
eze is in<br>
&gt; &gt;&gt; effect e.g. only bug fixes will be merged until a stable rele=
ase is<br>
&gt; &gt;&gt; out. Normally, after multiple release candidates, master is b=
ranched<br>
&gt; &gt;&gt; into a stable branch and the final official stable release is=
 created<br>
&gt; &gt;&gt; from that branch.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; This could potentially cause troubles for contributors, e.g. =
posting a<br>
&gt; &gt;&gt; set of patches and getting no response or waiting for merge i=
f a<br>
&gt; &gt;&gt; release candidate cycle is in effect. Any ideas/suggestions o=
n how we<br>
&gt; &gt;&gt; could improve this?<br>
&gt; &gt;&gt;<br>
&gt; &gt;<br>
&gt; &gt; We should create a separate branch at the first release candidate=
 and<br>
&gt; &gt; stabilize it until the official release. The feature freeze would=
 then<br>
&gt; &gt; only apply to that branch while invasive changes could be merged =
in<br>
&gt; &gt; master at all times. It would certainly make it easier on occasio=
nal<br>
&gt; &gt; contributors that may not be aware of the release schedule (at th=
e<br>
&gt; &gt; expense of the maintainers&#39; sanity...).<br>
&gt; &gt;<br>
&gt; &gt;&gt; For 2), the release roadmap is available at [1]. The roadmap =
is kind<br>
&gt; &gt;&gt; of a mess right now because bugs are assigned to older stable=
 releases<br>
&gt; &gt;&gt; giving the wrong impression that some stable releases are way=
 late.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; We would need a way to distinguish between bugs on already re=
leased<br>
&gt; &gt;&gt; versions and features targeting future versions. Perhaps some=
thing<br>
&gt; &gt;&gt; like [2-3] could be promising?<br>
&gt; &gt;&gt;<br>
&gt; &gt;<br>
&gt; &gt; Disciplining ourselves in opening Features with reasonable target=
<br>
&gt; &gt; dates on the bug tracker may be enough to make the current &quot;=
Roadmap&quot;<br>
&gt; &gt; plug-in useful.<br>
&gt; &gt;<br>
&gt; &gt;&gt; For 3), I would try to put tentative release dates on the roa=
dmap on<br>
&gt; &gt;&gt; Redmine or on a wiki article similar to [4]?<br>
&gt; &gt;&gt;<br>
&gt; &gt;<br>
&gt; &gt; I&#39;d prefer using the roadmap functionality. I&#39;m afraid th=
e wiki won&#39;t<br>
&gt; &gt; be maintained as releases slip.<br>
&gt; &gt;<br>
&gt; &gt;&gt; Another point that you did not mention is how we plan minor r=
eleases.<br>
&gt; &gt;&gt; I think we will need to define a clear policy for minor relea=
ses<br>
&gt; &gt;&gt; sooner than later because it is becoming quite painful to sup=
port<br>
&gt; &gt;&gt; three codebases (modules, ust, tools) with three stable branc=
hes...<br>
&gt; &gt;&gt; Perhaps in another thread?<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On a more general note, I think clear communication is the ke=
y here.<br>
&gt; &gt;&gt; I&#39;m wondering if a monthly summary of the development act=
ivities on<br>
&gt; &gt;&gt; LTTng and related projects could be interesting for the commu=
nity?<br>
&gt; &gt;&gt; Content example:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; - What have we accomplished in the past month.<br>
&gt; &gt;&gt; - What we are planning for the following month.<br>
&gt; &gt;&gt; - Release status (next stable tentative release dates, planne=
d minor<br>
&gt; &gt;&gt; releases, etc.)<br>
&gt; &gt;&gt; - Etc.<br>
&gt; &gt;&gt;<br>
&gt; &gt;<br>
&gt; &gt; Sounds good. It would also be a great opportunity to structure<br=
>
&gt; &gt; discussions around the planning.<br>
&gt; &gt;<br>
&gt; &gt; Regards,<br>
&gt; &gt; J=E9r=E9mie<br>
&gt; &gt;<br>
&gt; &gt;&gt; Any ideas/suggestions/constructive criticism on how we can im=
prove our<br>
&gt; &gt;&gt; release process are quite welcome!<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Thanks,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Christian<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; [1] - <a href=3D"http://bugs.lttng.org/projects/lttng/roadmap=
" target=3D"_blank">http://bugs.lttng.org/projects/lttng/roadmap</a><br>
&gt; &gt;&gt; [2] - <a href=3D"http://www.redmine.org/plugins/advanced_road=
map" target=3D"_blank">http://www.redmine.org/plugins/advanced_roadmap</a><=
br>
&gt; &gt;&gt; [3] - <a href=3D"http://www.redmine.org/plugins/redmine_miles=
tones" target=3D"_blank">http://www.redmine.org/plugins/redmine_milestones<=
/a><br>
&gt; &gt;&gt; [4] - <a href=3D"https://www.gnu.org/software/gdb/schedule/" =
target=3D"_blank">https://www.gnu.org/software/gdb/schedule/</a><br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On Tue, Jul 23, 2013 at 3:52 PM, Matthew Khouzam<br>
&gt; &gt;&gt; &lt;<a href=3D"mailto:matthew.khouzam@ericsson.com">matthew.k=
houzam@ericsson.com</a>&gt; wrote:<br>
&gt; &gt;&gt;&gt; Hello tracing rangers,<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; I am a bit confused about the whole release cycle system.=
<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; If you guys are in RC, I have a cool feature I was workin=
g on, where do<br>
&gt; &gt;&gt;&gt; I put it?<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; When are releases coming out? is it planned or a surprise=
 (I know it&#39;s<br>
&gt; &gt;&gt;&gt; planned)<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; What are your hard / soft deadlines?<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Thanks,<br>
&gt; &gt;&gt;&gt; Matthew<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; _______________________________________________<br>
&gt; &gt;&gt;&gt; lttng-dev mailing list<br>
&gt; &gt;&gt;&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@li=
sts.lttng.org</a><br>
&gt; &gt;&gt;&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinf=
o/lttng-dev" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listi=
nfo/lttng-dev</a><br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; _______________________________________________<br>
&gt; &gt;&gt; lttng-dev mailing list<br>
&gt; &gt;&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.=
lttng.org</a><br>
&gt; &gt;&gt; <a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lt=
tng-dev" target=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/=
lttng-dev</a><br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; J=E9r=E9mie Galarneau<br>
&gt; &gt; EfficiOS Inc.<br>
&gt; &gt; <a href=3D"http://www.efficios.com" target=3D"_blank">http://www.=
efficios.com</a><br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
</font></span></blockquote></div><br></div>

--047d7bd6bf827bc9e604e333878d--


--===============0795471089==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0795471089==--
