From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [GIT PULL v3] Accounting packet lost and discarded
 events at runtime
Date: Sun, 2 Aug 2015 15:38:25 +0000 (UTC)
Message-ID: <1202228235.2191.1438529905197.JavaMail.zimbra__16657.275267835$1438529978$gmane$org@efficios.com>
References: <55BD9166.3010901@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1ZLvLV-0001cw-3w
 for lttng-dev@lists.lttng.org; Sun, 02 Aug 2015 11:38:47 -0400
In-Reply-To: <55BD9166.3010901@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Julien Desfossez <jdesfossez@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Jeremie Galarneau <jgalar@efficios.com>
List-Id: lttng-dev@lists.lttng.org

----- On Aug 1, 2015, at 11:41 PM, Julien Desfossez jdesfossez@efficios.com wrote:

> This patchset is composed of commits in lttng-tools, lttng-ust and
> lttng-modules, it allows the sessiond, to report to the user the
> discarded events (when a channel is in discard mode) or the lost packets
> (when a channel is in overwrite mode).
> 
> Please pull from:
> https://github.com/jdesfossez/lttng-tools-dev/tree/seqnum
> a312e89 Store the instance id and packet_seq_num in indexes
> e40456e kernctl commands to extract the stream instance id
> 53d9b1d Account the lost packets in snapshot mode
> 17d0d29 Display discarded and lost events at destroy and stop
> 291246b Extract the lost packets and discarded events counters
> 0965b2f Metadata for instance_id and packet_seq_num
> a0badfd Reference pointers from ust_app_chan to parent structs
> 082f79d Explicitly stop the session on lttng destroy
> 
> https://github.com/jdesfossez/lttng-modules-dev/tree/seqnum
> fa326dd Add stream instance id to the packet header
> cf556ea Add a packet sequence number

Just merged those two commits into lttng-modules master.
They don't have locked-step requirements with tools.

> 
> https://github.com/jdesfossez/lttng-ust-dev/tree/seqnum
> 66eb100 Export the stream instance ID
> 72d75d7 Generate and export the sequence number
> 885e9ba Add stream instance id to the packet header

Reviewed those commits. At this point, after taking care of
the last comments, each should have my acked-by. However, those
need to wait until Jeremie can review the tools changes, because
those need to be done in locked-step.

Are there any changes required in Babeltrace associated with the
new packet context fields ?

Thanks,

Mathieu

> 
> 
> Since we are in the last sprint of the 2.7 release, I will try to keep
> these branches up-to-date by rebasing regularly until the maintainers
> have some time to review and merge into master, so the commit IDs might
> change, but the commit messages won't. I can resubmit as emails instead
> of a pull request if it is easier for the review.
> 
> Change from v2:
> - actually pushed the updates intended for v1 in UST and tools...
> - fixed the comments from Mathieu on the v2
> 
> Change from v1:
> - the packet sequence number is not dependant on the subbuf_size and now
> always a uint64_t, so it got rid of the need of the
> packet_seq_num_padding field
> 
> Original cover letter:
> The reporting is detailled on a per-channel basis in the "lttng list"
> command (and associated API calls) at runtime. On lttng stop/destroy, a
> warning is now displayed to the user if events/packets were
> discarded/lost during the session.
> 
> The information about the packet lost is extracted from a packet
> sequence number now written in each CTF packet and CTF index, allowing
> the relayd and the viewers to know when parsing the trace/index that
> entire packets were lost between two data packets.
> 
> Finally, a stream_instance_id is now written in each packet, this
> feature allows a viewer to link multiple tracefiles belonging to the
> same channel and stream. This is particularly useful when dealing with
> tracefile rotation because the viewers will now be able to compute the
> accurate number of discarded events.
> 
> Julien
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
