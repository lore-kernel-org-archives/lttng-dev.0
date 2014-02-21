From: Matthew Khouzam <matthew.khouzam@ericsson.com>
Subject: Reading live traces in eclipse
Date: Fri, 21 Feb 2014 15:23:12 -0500
Message-ID: <5307B5B0.8010208__2585.34269310093$1393014303$gmane$org@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg21.ericsson.net ([198.24.6.65])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <matthew.khouzam@ericsson.com>) id 1WGwdf-0000as-FV
	for lttng-dev@lists.lttng.org; Fri, 21 Feb 2014 15:24:08 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi All,
I figured I would give a status update to what's going on in eclipe wrt
live trace reading.

We currently had a little push to get it up and running, here is the
result:

Reading CTF while it's live: should work 100%
    reading TSDL fragments and updating the trace: done
    reading streams while they grow: done
    reading streams as they arrive: done

Reading the state system while it's being written: should work 100%
    reading a state system before it's closed: done
    views updating before the state system is closed: done

Connecting to the relayd: prototype is done (github)
    connecting to the relayd: done
    requesting more of the trace: done

Gluing the whole thing together... still needs to be done

For now, if you wish to read live traces for now here's what you can do:

before:

CTFTrace trace = new CTFTrace(tracefile);
CTFTraceReader reader = new CTFTraceReader(trace);
while (reader.advance()) {
    // event stuff goes here
    reader.getCurrentEventDef();
}

Now with live support:

CTFTrace trace = new CTFTrace(tracefile);
CTFTraceReader reader = new CTFTraceReader(trace);
reader.setLive(true);
while (reader.advance() && !reader.isLive()) {
    while (reader.getCurrentEventDef()!= null) {
        Thread.sleep();
        reader.advance();
    }
    // event stuff goes here
    reader.getCurrentEventDef();
}

// probably won't happen that often compared to growing streams
handler hasMoreMetadata(String data){
    Metadata md = new Metadata(trace);
    md.parseTextFragment(data); 
}

// probably won't happen that often compared to growing streams
handler hasMoreStreams(File f) {
    trace.addStreamFile(f);
}


All of this extra work will be internally handled by TMF.
