From: David Goulet <dgoulet@efficios.com>
Subject: Re: [PATCH lttng-tools] Fix: change default UST per UID
 subbuffer size
Date: Tue, 07 May 2013 12:48:11 -0400
Message-ID: <5189304B.3050108__6108.75595962188$1367945335$gmane$org@efficios.com>
References: <1367942692-10203-1-git-send-email-dgoulet@efficios.com>
	<20130507161904.GE6601@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1UZl3q-0003dG-JL
	for lttng-dev@lists.lttng.org; Tue, 07 May 2013 12:48:18 -0400
In-Reply-To: <20130507161904.GE6601@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org



Mathieu Desnoyers:
> * David Goulet (dgoulet@efficios.com) wrote:
>> The default per UID subbuffer size are changed from 4096 bytes to 131072
>> bytes (128k).
>>
>> Fixes #524
>>
>> Signed-off-by: David Goulet <dgoulet@efficios.com>
>> ---
>>  src/bin/lttng-sessiond/channel.c |   40 +++++++++++++++++++++++++-------------
>>  src/bin/lttng-sessiond/channel.h |    3 ++-
>>  src/bin/lttng-sessiond/cmd.c     |   14 ++++++++-----
>>  src/common/defaults.c            |    9 ++++++---
>>  src/common/defaults.h            |   25 ++++++++++++++++++------
>>  src/lib/lttng-ctl/lttng-ctl.c    |    6 +++++-
>>  6 files changed, 67 insertions(+), 30 deletions(-)
> [...]
> 
>> diff --git a/src/common/defaults.h b/src/common/defaults.h
>> index fb6a975..4606976 100644
>> --- a/src/common/defaults.h
>> +++ b/src/common/defaults.h
>> @@ -148,7 +148,8 @@
>>  /* User space defaults */
>>  
>>  /* Must be a power of 2 */
>> -#define DEFAULT_UST_CHANNEL_SUBBUF_SIZE     4096    /* bytes */
>> +#define DEFAULT_UST_PID_CHANNEL_SUBBUF_SIZE 4096    /* bytes */
>> +#define DEFAULT_UST_UID_CHANNEL_SUBBUF_SIZE 131072  /* bytes */
> 
> Since we introduce DEFAULT_UST_{PID,UID}_* for SUBBUF_SIZE, I think it
> would make sense to introduce PID and UID defaults for SUBBUF_NUM and
> OUTPUT. They can simply map to their respective DEFAULT_UST_CHANNEL
> defaults. I recommend we rename DEFAULT_UST_CHANNEL_* defaults to
> _DEFAULT_UST_CHANNEL_* (leading underscore) so we ensure we don't forget
> any site that uses the old macro. The code that uses those should always
> use the UID/PID macros from now on. Having this in place will make it
> much easier to make default value changes in the future if need be
> without the risk of forgetting to changes some instances in the code
> (see commit 9f778c9a8f1d65f5bfdde7cfd7294492d6fdd34c as an example of a
> case we had to fix an issue that arised from inconsistency).

Not sure I understand here. Don't you mean rename DEFAULT_CHANNEL_* with
an underscore in order to make sure only domain specific values are used
in the code base? or every UST macros that are not used outside the
scope of default.h ?

Actually, subbuffer size are accessed through a getter in default.c
returning the max() value between our defaults and a page size. That
said, this means their should be *no* call site that uses the subbuffer
size macro.

> 
> Moreover, I think you forgot to update the documentation (manpage +
> enable-channel --help).

Right.

Cheers!
David

> 
> Thanks,
> 
> Mathieu
> 
