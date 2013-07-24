From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: Release strategy
Date: Wed, 24 Jul 2013 10:00:58 -0400
Message-ID: <51EFDE1A.5020206__23816.2561007359$1374674667$gmane$org@voxpopuli.im>
References: <51EEDF15.4090300@ericsson.com>
	<CAGDH53=w6Wgat9vpL+iWd4mBfyM9CQuxGJEkN4095AeBB-LWog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.182])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <alexmonthy@voxpopuli.im>) id 1V1zdB-0004Ze-MI
	for lttng-dev@lists.lttng.org; Wed, 24 Jul 2013 10:01:35 -0400
In-Reply-To: <CAGDH53=w6Wgat9vpL+iWd4mBfyM9CQuxGJEkN4095AeBB-LWog@mail.gmail.com>
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

On 13-07-23 11:30 PM, Christian Babeux wrote:
> [...]
>
> For 2), the release roadmap is available at [1]. The roadmap is kind
> of a mess right now because bugs are assigned to older stable releases
> giving the wrong impression that some stable releases are way late.
>
> We would need a way to distinguish between bugs on already released
> versions and features targeting future versions. Perhaps something
> like [2-3] could be promising?

I haven't looked in a while, but I think if you set a milestone as
Closed in Redmine, it prevents people from assigning new issues to it.
You can also change the target date at any time. For past releases, the
target date should reflect the actual date of the release.

> [...]
>
> - What have we accomplished in the past month.
> - What we are planning for the following month.
> - Release status (next stable tentative release dates, planned minor
> releases, etc.)
> - Etc.
>
> Any ideas/suggestions/constructive criticism on how we can improve our
> release process are quite welcome!

I'd say the most important would be announcing the feature-freeze and
(tentative) release dates in advance. Of course it's hard to give
precise dates long in advance, but just announcing on the ML let's say
"We're looking at a feature freeze 2 weeks from now, and the release 1
month after that" would allow people to plan accordingly if they want to
contribute features for the following release, or wait for the one after
that.

my 2c,

Cheers,
Alex

>
> Thanks,
>
> Christian
>
> [1] - http://bugs.lttng.org/projects/lttng/roadmap
> [2] - http://www.redmine.org/plugins/advanced_roadmap
> [3] - http://www.redmine.org/plugins/redmine_milestones
> [4] - https://www.gnu.org/software/gdb/schedule/
>
> On Tue, Jul 23, 2013 at 3:52 PM, Matthew Khouzam
> <matthew.khouzam@ericsson.com> wrote:
>> Hello tracing rangers,
>>
>> I am a bit confused about the whole release cycle system.
>>
>> If you guys are in RC, I have a cool feature I was working on, where do
>> I put it?
>>
>> When are releases coming out? is it planned or a surprise (I know it's
>> planned)
>>
>> What are your hard / soft deadlines?
>>
>> Thanks,
>> Matthew
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
