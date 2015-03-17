From: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Subject: Re: userspace-rcu-0.8.6 problems on MacOSX
Date: Tue, 17 Mar 2015 15:12:11 -0400
Message-ID: <55087C8B.8050504__11491.0264187076$1426619922$gmane$org@voxpopuli.im>
References: <18312E03-EE49-4807-8227-7DE555AFFD28@rfc1035.com>
 <5501CBE5.1020702@voxpopuli.im>
 <CAJ7wx-EgDGitV7swToCZohrmept1pi+OkgBCeFXmkwS25GBP8Q@mail.gmail.com>
 <55035469.9050001@voxpopuli.im>
 <979006401.6127.1426468668277.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from ironport2-out.teksavvy.com ([206.248.154.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <alexmonthy@voxpopuli.im>) id 1YXwuZ-0007m2-Co
 for lttng-dev@lists.lttng.org; Tue, 17 Mar 2015 15:12:20 -0400
In-Reply-To: <979006401.6127.1426468668277.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jim Reid <jim@rfc1035.com>, lttng-dev@lists.lttng.org, Zifei Tong <soariez@gmail.com>
List-Id: lttng-dev@lists.lttng.org


Thanks Mathieu! With all the latest fixes, liburcu master can now 
compile as-is on Mac.


On 2015-03-15 9:17 PM, Mathieu Desnoyers wrote:
>
>> However, by doing so those tests now hang on my Mac test system (whereas
>> before they would get skipped). Is it possible those tests don't even
>> work on Mac?
> Do they really hang, or just take a very long time to run ?
> Can you reproduce this easily ?
>
>

Quite reproducible, yes. I let 'make regtest' run for a couple hours, 
and it stuck at:

cd ../benchmark && ./runall.sh && cd ..
Executing batch RCU test
./test_urcu_gc 4 4 10 -d 0 -b 1


Running the last command by hand also hangs. It's using very little CPU 
in both cases.
