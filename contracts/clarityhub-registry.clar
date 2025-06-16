;; ------------------------------------------------------------
;; Contract: clarityhub-registry
;; Purpose: On-chain registry for Clarity smart contracts
;; Author: [Your Name]
;; ------------------------------------------------------------

(define-constant ERR_NOT_FOUND (err u100))
(define-constant ERR_UNAUTHORIZED (err u101))

(define-data-var next-id uint u1)

;; Structure for registered contracts
(define-map contracts
  uint
  {
    name: (string-ascii 50),
    description: (string-ascii 200),
    version: (string-ascii 20),
    contract-principal: principal,
    registered-by: principal,
    verified: bool
  }
)

;; === Register a new contract ===
(define-public (register-contract
  (name (string-ascii 50))
  (description (string-ascii 200))
  (version (string-ascii 20))
  (contract-principal principal))
  (let (
    (id (var-get next-id))
  )
    (begin
      (map-set contracts id {
        name: name,
        description: description,
        version: version,
        contract-principal: contract-principal,
        registered-by: tx-sender,
        verified: false
      })
      (var-set next-id (+ id u1))
      (ok id)
    )
  )
)

;; === Update contract metadata (only by original submitter) ===
(define-public (update-contract
  (id uint)
  (description (string-ascii 200))
  (version (string-ascii 20)))
  (match (map-get? contracts id)
    entry
    (if (is-eq (get registered-by entry) tx-sender)
        (begin
          (map-set contracts id {
            name: (get name entry),
            description: description,
            version: version,
            contract-principal: (get contract-principal entry),
            registered-by: (get registered-by entry),
            verified: (get verified entry)
          })
          (ok true)
        )
        ERR_UNAUTHORIZED
    )
    ERR_NOT_FOUND
  )
)

;; === Get contract metadata by ID ===
(define-read-only (get-contract (id uint))
  (match (map-get? contracts id)
    contract (ok contract)
    ERR_NOT_FOUND
  )
)

;; === Verify contract (could be extended to DAO vote) ===
(define-public (verify-contract (id uint))
  (match (map-get? contracts id)
    contract
    (begin
      (map-set contracts id {
        name: (get name contract),
        description: (get description contract),
        version: (get version contract),
        contract-principal: (get contract-principal contract),
        registered-by: (get registered-by contract),
        verified: true
      })
      (ok true)
    )
    ERR_NOT_FOUND
  )
)
