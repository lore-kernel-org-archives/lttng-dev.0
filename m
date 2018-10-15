From: Francis Deslauriers <francis.deslauriers@efficios.com>
Subject: [BETA RELEASE] LTTng Scope 0.4
Date: Mon, 15 Oct 2018 12:19:24 -0400
Message-ID: <CADcCL0gyN=vAPLAYX010NAoCyg_XCqzW2at7PtbZdrjSbfRChw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lttng-dev <lttng-dev@lists.lttng.org>, diamon-discuss@lists.linuxfoundation.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: lttng-dev@lists.lttng.org

Hi all,

We are announcing the release of LTTng Scope 0.4.0.

This release has a few improvements over LTTng Scope 0.3:

* Open more than one trace thanks to the new "Trace Project Setup"
  window. (e.g. Kernel + UST traces)

  You can always reopen this window to add traces to or remove traces
  from the current trace project by clicking
  "File" -> "Project Setup..." or by right-clicking the project item in
  the left pane and clicking "Project Setup".

* Event count chart: use vertical bars instead of an area chart. A given
  bar indicates the number of event records of which the timestamps are
  between the beginning and the end of the bar.

* Event count chart: use natural ticks, depending on the current zoom
  level, on the horizontal (time) axis. For example, the difference
  between individual ticks can be 100 ms, 500 ms, 1 s, 2 s, 15 s, 30
  minutes, 1 day, etc.

* Event count chart: add axis units ("Count / Time") below the view's
  title on the left.

* Add the version to the main window's title bar.

* Bug fix: refresh the views when you move vertical dividers or when you
  resize the main window.

* Bug fix: event count chart: round tick labels correctly to avoid
  noticing floating point number errors.

Of course, because LTTng Scope's development is still in the beta phase,
you could discover bugs when trying the tool. Feel free to report them
on GitHub: <https://github.com/lttng/lttng-scope/issues>.

Project's description and screenshot:
    <https://lttng.org/beta/#lttng-scope>

GitHub page:
    <https://github.com/lttng/lttng-scope>

Installer for Linux:
    <https://lttng.org/files/lttng-scope/lttng-scope-0.4.0-linux-x64-installer.run>

Installer for Windows:
    <https://lttng.org/files/lttng-scope/lttng-scope-0.4.0-windows-installer.exe>

Installer for macOS:
    <https://lttng.org/files/lttng-scope/lttng-scope-0.4.0-osx-installer.dmg>

On the behalf of the EfficiOS team,

--
Francis Deslauriers
Software developer
EfficiOS inc.
