;;; FOR-THE-HOST --- Code for the host of the workshop, not attendees
;;
;; Author: Howard Abrams
;; Copyright © 2016, Howard Abrams, all rights reserved
;; Created: 2016 Mar 16
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;;    This is code to simply set up the host of this workshop with an
;;    environment that maximizes the screen estate so that everyone
;;    can see the most amount of information projected.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Change log:
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:

;; Got the packages?
(when (not (require 'use-package nil t))
  (package-install 'use-package))

(use-package demo-it
  :ensure t)

(use-package org-tree-slide
  :ensure t
  :config
  (org-tree-slide-simple-profile))

;; ----------------------------------------------------------------------
;;  Create each function that represents a "presentation frame"

(defun org-mode-intro-load-presentation ()
  "Display for-the-host.org (an 'org-mode' file) as a presentation."
  ;; After the demonstration, we'll restore the original state
  (demo-it-frame-fullscreen)
  (delete-other-windows)
  (demo-it-presentation "instructions.org"))

(defun org-mode-intro-load-part-2 ()
  "Load a pre-written org file with predefined sections."
  (interactive)
  ;; If we switch to the original sandbox file, we can replace that
  ;; buffer window with a new one.
  (pop-to-buffer "sandbox.org")
  (demo-it-load-file "sandbox.org" 'side 2)
  )

;; ----------------------------------------------------------------------
;; Demonstration and/or Presentation Order

(defun org-mode-intro-start-presentation ()
  "Start hosting mode for this workshop.

Rebind F12 to advance the presentation, while C-F12 will load the
next file to edit."
  (interactive)

  (define-key demo-it-mode-adv-map (kbd "C-<f12>") 'demo-it-step)
  (define-key demo-it-mode-adv-map (kbd "<f12>") 'demo-it-presentation-advance)

  (demo-it-start (list 'org-mode-intro-load-presentation
                       'org-mode-intro-load-part-2) t))

;; ----------------------------------------------------------------------
;; Start the presentation whenever this script is evaluated. Good idea?

(org-mode-intro-start-presentation)

(provide 'org-mode-intro)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; for-the-host.el ends here
