From: Julien Desfossez <jdesfossez@efficios.com>
Subject: Re: [RFC] on-disk multiple tracefiles circular buffer
Date: Thu, 14 Feb 2013 00:11:59 -0500
Message-ID: <511C721F.6060600__15388.2741266445$1360818779$gmane$org@efficios.com>
References: <501458912.795461360787706118.JavaMail.root@srv12.zimbra.polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from fukushima.klipix.org ([194.250.102.243])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jdesfossez@efficios.com>) id 1U5r79-00034V-UF
	for lttng-dev@lists.lttng.org; Thu, 14 Feb 2013 00:12:08 -0500
In-Reply-To: <501458912.795461360787706118.JavaMail.root@srv12.zimbra.polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Michel Dagenais <michel.dagenais@polymtl.ca>
Cc: lttng-dev@lists.lttng.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
List-Id: lttng-dev@lists.lttng.org

>> -C limits the maximum file size and -W the amount of such files to
>> keep on disk.
> 
> Do you round up to the next packet / subbuffer / event?
We won't exceed the maximum file size specified, so when we detect that
a write will be too big, we rotate the tracefile before writing in it.
The smallest file size the user can specify will be the subbuffer size.

> In the upcoming releases, there should be small indexes telling where each packet / subbuffer starts in each file. How are these index files affected by these switches?
There will be one index file per tracefile, so the logic to write the
index file will be the same as the logic to write the tracefile : when
we rotate the tracefile, we rotate the index file.

It is a good question since we might end up with a lot of files though,
for each channel : 2*CPU*tracefile_count.

I'd like to hear what the others have to say about that.

Thank you,

Julien
