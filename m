From: Anand Buddhdev <anandb@ripe.net>
Subject: Re: Compile failure on OSX 10.8
Date: Wed, 26 Jun 2013 17:50:07 +0200
Message-ID: <51CB0DAF.6010507__22738.649036228$1372261849$gmane$org@ripe.net>
References: <51C46FFC.7050407@ripe.net>
	<CAGDH53k9wAeu6cBsSCtauX0ADgFW9B09vz7Cfq2B=Yhw3-pCNw@mail.gmail.com>
	<51C47EE0.9080208@ripe.net>
	<CAGDH53mD-8jWechmKhVWyS7nY_CJQQgdDXfLp1V=gsAkmw53eQ@mail.gmail.com>
	<51C49E0C.8020808@ripe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from postgirl.ripe.net ([193.0.19.66])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <anandb@ripe.net>) id 1Urrz1-0005hw-AA
	for lttng-dev@lists.lttng.org; Wed, 26 Jun 2013 11:50:11 -0400
In-Reply-To: <51C49E0C.8020808@ripe.net>
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

Hi Christian,

Were you able to figure out from the config.log files why the
architecture detection wasn't working properly?

Anand

On 21/06/2013 20:40, Anand Buddhdev wrote:

> Hi Christian,
> 
> I've attached both here.
> 
> Anand
> 
> On 21/06/2013 18:51, Christian Babeux wrote:
> 
>> Hmm that's really weird :/. For some reason configure detect an i386
>> CPU which is certainly not right. Could you post your config.log with
>> and without the --host flag (specifying which is which)?
>>
>> There might be some slight incompatibilities on OSX and the CPU
>> detection mechanism we are using...
