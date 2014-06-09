From: Nathan Lynch <Nathan_Lynch@mentor.com>
Subject: Re: [RFC PATCH 1/1] check if set_schedaffinity works in
 configure.ac
Date: Mon, 9 Jun 2014 13:52:38 -0500
Message-ID: <53960276.2050809__7612.14907183803$1402340042$gmane$org@mentor.com>
References: <5394C476.2050707@gmail.com> <5394C521.4040001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Nathan_Lynch@mentor.com>) id 1Wu4gY-00027Y-PW
 for lttng-dev@lists.lttng.org; Mon, 09 Jun 2014 14:52:52 -0400
In-Reply-To: <5394C521.4040001@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On 06/08/2014 03:18 PM, Pranith Kumar wrote:
> On 06/08/2014 04:15 PM, Pranith Kumar wrote:
>> On some systems set_schedaffinity exists but return "-1" when
>> called. Tests fail in such cases ("test_urcu_hash")
>> 
>> Check if we can call set_schedaffinity and define accordingly
> I just realized that this is a common mailing list. This is for
> userspace-rcu library. I am trying to use it on an Nvidia Tegra K1
> device.

It seems odd that sched_setaffinity would fail... what is the value of
errno associated with the failed calls?

(Also, you have the name of the function right in your patch, but need
to correct it in the patch subject and description --
"sched_setaffinity" not "set_schedaffinity".)
